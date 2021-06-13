#include <unistd.h>
#include <string.h>
#include <stdarg.h>
#include <limits.h>

static int write_stdout(const char *token, int length)
{
	int rc;
	int bytes_written = 0;

	do {
		rc = write(1, token + bytes_written, length - bytes_written);
		if (rc < 0)
			return rc;

		bytes_written += rc;
	} while (bytes_written < length);

	return bytes_written;
}

static char * reverse(char *string ){

	int length	= strlen(string) - 1;
	char *first = string , * last = string + length;

	for(int i = 0 ; i <= length/2 ; i++ ){

		char aux = *first;
		*first = *last;
		*last = aux;

		first++;
		last--;

	}

	return string;
}


static char * myitoa(char *mod,int base,int nr , char *string ){

	unsigned int convertor; //aceasta variabila este folosita pentru a face conversiile numerelor negative 
	int i = 0 ;
	int ok = 0 ; // aceasta variabila va fi folosita sa vedem daca numarul a fost negativa in cazul in care trebuie sa printam %d

	if( nr == 0 ){

		string[i] = '0';
		string[i+1] = '\0';
		return string;

	}	

	else{

		if( nr < 0 && nr!= INT_MIN && strcmp(mod,"%d") == 0){
			
			nr = -nr;
			ok = 1;
		
			while(nr != 0 ){

				int LastDigit = nr % base ;
				string[i] = ( LastDigit > 9 ) ? (LastDigit - 10 ) + 'a' : LastDigit + '0';	
				nr = nr / base ;
				i++;
			
			}
		}

		else{

			if( nr < 0 )
				convertor = UINT_MAX + 1 + nr; //se face trecerea unui numar negativ 
			else
				convertor = nr;

			if( nr == INT_MIN && strcmp(mod,"%d") == 0 ) // Ne folosim de faptul ca UINT_MAX = INT_MAX - INT_MIN
				ok = 1 ;
									
			while(convertor > 0 ){

				int LastDigit = convertor % base ;
				string[i] = ( LastDigit > 9 ) ? (LastDigit - 10 ) + 'a' : LastDigit + '0';	
				convertor = convertor / base ;
				i++;
			}
		
		}

		if( ok == 1 ){

			string[i++] = '-';//in cazul in care numarul a fost negativ la finalul conversiei lui se adauga unu '-'
			
		}

		string[i] = '\0';

		string = reverse(string);//functie care inverseaza numarul care este reprezentat de un string  	

	}
	
	return string;

}



int iocla_printf(const char *format, ...)
{
	

	int NrOfCharacters = 0;	

	va_list arg;
	
	va_start(arg,format);
	

	char copy[1000000]; // Facem o copie a stringului oferit ca parametru 
	strcpy(copy,format);

	char aux[10000]; // Vom salva ce se afla dupa "%argument" 
	char mod[10000]; // Vom pune in acest vector "%argument" pentru a stii in ce caz ne incadram
	char convertor[1000000];
	char help[100000];
	char *update = copy; //pt a da skip daca exista mai multe % 

	while( strstr(update,"%") != NULL ){

		char *find = strstr(update,"%"); // Am afalt pozitia unde se afla "%argument" 
		strncpy(help,find+1,1);//vedem daca dupa % se afla un "argument" sau este un alt simbol pentru a sti cum sa procedam			

		if( strcmp(help,"%") != 0 )
		{

			memcpy(mod,find,2); // Copiem doar "%argument" ca mai apoi sa stim in ce caz ne aflam 

			if( strcmp(mod,"%d") == 0){

				strcpy(convertor,myitoa(mod,10,va_arg(arg,int),convertor));			
			
			}

			if( strcmp(mod,"%u") == 0 ){

					
				strcpy(convertor,myitoa(mod,10,va_arg(arg,int),convertor));
				
			}		

			if( strcmp(mod,"%c") == 0 ){ // stim ca in cazul caracte acestea ocupa o singura pozitie 
	;
				convertor[0] = (char)va_arg(arg,int);
				convertor[1] = '\0';
			
			}


			if( strcmp(mod,"%x") == 0 ){

				strcpy(convertor,myitoa(mod,16,va_arg(arg,int),convertor));
			}

				
			if( strcmp(mod,"%s") == 0 ){

				strcpy(convertor,va_arg(arg,char *));
			}


			strcpy(aux,find+2); // se copiaza tot sirul de dupa argument 
			strcpy(copy+(strlen(copy)-strlen(find)),convertor);// copiem in locul lui "%argument" numarul nostru 
			strcat(copy,aux); // atasam partea care a fost copiata initial si care se afal dupa "%argument"	
		}
		else
			{
				strcpy(find,find+1); //stim ca %% la printare este % asa ca "stergem" unul 	
				update = find + 1 ;	//pentru a nu da peste % pe care l-am convertit din cele 2 % ii dam skip 	
			}


	}

	NrOfCharacters = NrOfCharacters + write_stdout(copy,strlen(copy));	

	va_end(arg);

	return NrOfCharacters;
}



#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <limits.h>

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


static char * itoa(int base,int nr , char *string ){

	unsigned int convertor = nr ; 
	int i = 0 ;
	int ok  = 0 ;

	
	if( nr == 0 ){

		string[i] = '0';
		string[i+1] = '\0';
		return string;

	}

	if( nr < 0 ){

		convertor = UINT_MAX +1 + nr;
		
	}



	while(convertor > 0 ){

		int LastDigit = convertor % base ;
		string[i] = ( LastDigit > 9 ) ? (LastDigit - 10 ) + 'a' : LastDigit + '0';	
		convertor = convertor / base ;
		i++;
	}
	

	string[i] = '\0';

	string = reverse(string);	

	return string;

}


int main() {


	printf("%d",-2147483648);

	char a[100] = "%%d";
	int number;
	char character;
	char sir[50];

	scanf("%d",&number);
	//scanf("%c",&character);
	//scanf("%s",sir);

	char copy[100]; // Facem o copie a stringului oferit ca parametru 
	strcpy(copy,a);

	char aux[100]; // Vom salva ce se afla dupa "%argument" 
	char mod[10]; // Vom pune in acest vector "%argument" pentru a stii in ce caz ne incadram
	char convertor[100];
	char help[10];
	char *update = copy;//pt a da skip daca exista mai multe % sau \ 

	//printf("%ld \n", strlen("%d"));

	while( strstr(update,"%") != NULL ){

		char *find = strstr(update,"%"); // Am afalt pozitia unde se afla "%argument" 
		strncpy(help,find+1,1);			
		//printf("%s\n",help);

		if( strcmp(help,"%") != 0 )
		{

			memcpy(mod,find,2); // Copiem doar "%argument"
			//printf("%s\n",mod);	

			if( strcmp(mod,"%d") == 0){

				strcpy(convertor,itoa(10,number,convertor));			
			
			}

			if( strcmp(mod,"%u") == 0 ){

					
				strcpy(convertor,itoa(10,number,convertor));
				
			}		

			if( strcmp(mod,"%c") == 0 ){
	;
				convertor[0] = character;
				convertor[1] = '\0';
			
			}


			if( strcmp(mod,"%x") == 0 ){

				strcpy(convertor,itoa(16,number,convertor));
			}

				
			if( strcmp(mod,"%s") == 0 ){

				strcpy(convertor,sir);
			}


			strcpy(aux,find+2);
			strcpy(copy+(strlen(copy)-strlen(find)),convertor);
			strcat(copy,aux);	
		}
		else
			{
				strcpy(find,find+1);	
				update = find + 1 ;		
			}


	}


	printf("%s",copy);


	
   	//Nrofchar = Nrofchar + write_stdout(a,strlen(a));	


   	return 0;
}
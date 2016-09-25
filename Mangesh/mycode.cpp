#include <iostream>
#include <string>

using namespace std ;

class Bus {
	
	public :
int Id ;
int Cap ;
int Fill ;
int Route ;
int Pos ;

    Bus(){
		Id = 0;
		Cap=0;
		Fill=0;
		Route=0;
		Pos=0;
	    }
	    
	 Bus(int a, int b, int c , int d, int e){
		Id = a;
		Cap=b;
		Fill=c;
		Route=d;
		Pos=e;
	    }
	    
} ;

class Stop {
	public :
int Num ;
string Label ;	

   Stop(){
		Num = 0;
		Label = "Does not exist" ;
	}
		
   Stop(int a, string b ){
        Num = a ;
        Label = b;
	}
} ;

int main()
{
   return 0; 
}
	
	



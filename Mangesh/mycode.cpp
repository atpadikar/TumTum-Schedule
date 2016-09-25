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
int Stds ;
float a1;
float a2;
float a3;
float b1;
float b2;
float b3;
float b4;

   Stop(){
		Num = 0;
		Label = "Does not exist" ;
		Stds = 0; a1 = 0 ; a2 = 0 ; a3 = 0 ; b1 = 0 ; b2 = 0 ; b3 = 0 ; b4 = 0 ;
	}
		
   Stop(int a, string b , int c , float d, float e, float f, float g, float h, float i, float j ){
        Num = a ;
        Label = b;
        Stds = c ;
        a1 = d ; a2 = e ; a3 = f ; b1 = g ; b2 = h ; b3 = i ; b4 = j ; 
	}
} ;



int main()
{  int Nbus, Nstop , Nroute ;
	
	cin >> Nbus ; cin >> Nstop ; cin >> Nroute ;
	
	Bus TumTum[Nbus] ; 
	
	Stop BusStop[Nstop] ; 
   for(int i=0 ; i < Nbus ; i++ )
      { cin >> TumTum[i].Id ;
		cin >> TumTum[i].Cap ;
		cin >> TumTum[i].Fill ;
		cin >> TumTum[i].Route ;
		cin >> TumTum[i].Pos ;  
	  }
	  
	for(int i=0 ; i < Nstop ; i++ )
      { cin >> BusStop[i].Num;
		cin >> BusStop[i].Label ;
		cin >> BusStop[i].Stds ;
		cin >> BusStop[i].a1 ;
		cin >> BusStop[i].a2 ;  
	    cin >> BusStop[i].a3 ;
		cin >> BusStop[i].b1 ;
	    cin >> BusStop[i].b2 ;
	    cin >> BusStop[i].b3 ; 
    	cin >> BusStop[i].b3 ;		    
	  }  
	  
	  
	  cout << BusStop[5].Label ;
	  

}
	
	



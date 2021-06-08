sirkaKapsle = 80;
vyskaKapsle = 250;
vysecKapsle = 80;
polomerKvetinace = 200;
polomerRohu = 10; 
tloustkaSteny = 3;
polomerTrychtyre = sirkaKapsle/4;
vyskaValceNadTrychtyrem = 10;
tloustkaStenTrubicky = 1;
polomerTrubicky = 6;
polomerZahybuTrubicky = 1.5*vyskaValceNadTrychtyrem;
polomerOhybuHackuNaZaveseni = 20;
vysecHackuNaZaveseni = 4/5 * vysecKapsle;
$fn = 100;
zplosteniTrychtyre = 0.5;

module hacek($fn = 100){      // hacek na zaveseni
    translate([-polomerKvetinace-sirkaKapsle/2+tloustkaSteny,0,vyskaKapsle])
        rotate([0,0,-vysecHackuNaZaveseni/2])
            difference(){                                                               
                rotate_extrude(angle = vysecHackuNaZaveseni)
                    translate([polomerKvetinace-polomerOhybuHackuNaZaveseni,0,0])
                        circle(polomerOhybuHackuNaZaveseni);
            
                rotate([0,0,-5])                                                            // odecteni vnitrku
                    rotate_extrude(angle = vysecHackuNaZaveseni+10)
                        translate([polomerKvetinace-polomerOhybuHackuNaZaveseni,0,0])
                        circle(polomerOhybuHackuNaZaveseni-tloustkaSteny);
                
                
                translate([0,0,-50*sin(vysecHackuNaZaveseni/2)*(polomerKvetinace+polomerOhybuHackuNaZaveseni)])     // odecteni spodni casti
                    cube(100*sin(vysecHackuNaZaveseni/2)*(polomerKvetinace+polomerOhybuHackuNaZaveseni), center = true);
  
                rotate([0,0,vysecHackuNaZaveseni/2])              
                    translate([polomerTrubicky-tloustkaSteny+polomerKvetinace,0,0])             // vyriznuti prutoku hadicky
                        cylinder(r=polomerTrubicky-tloustkaStenTrubicky, h = polomerOhybuHackuNaZaveseni);
            }    

}
                



module kapsleZakladniTvar($fn = 100){ 
    translate([-polomerKvetinace-sirkaKapsle/2,0,0])            // celkove posunuti a otoceni kapsle
        rotate([0,0,-vysecKapsle/2]){
            
            rotate_extrude(angle=vysecKapsle)                  // deravy obdelnik jako bocni prurez 
                translate([polomerKvetinace,0,0])
                    difference(){
                        square([sirkaKapsle, vyskaKapsle]);
                        
                        translate([tloustkaSteny,tloustkaSteny,0])
                            square([sirkaKapsle-2*tloustkaSteny, vyskaKapsle-tloustkaSteny]);
                    }
                    
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    
            linear_extrude(height=vyskaKapsle)  // pudorys zaobleneho boku
                difference(){                   
                    hull(){     
                        translate([polomerKvetinace+polomerRohu,0,0])               // vnejsiCast
                            circle(polomerRohu);
                        translate([polomerKvetinace+sirkaKapsle-polomerRohu,0,0])
                            circle(polomerRohu);
                    }
                    
                    hull(){                                                         // odecteni zmenseneho vnitrku
                        translate([polomerKvetinace+polomerRohu,0,0])
                            circle(polomerRohu-tloustkaSteny);
                        translate([polomerKvetinace+sirkaKapsle-polomerRohu,0,0])
                            circle(polomerRohu-tloustkaSteny);
                    }
                    
                    translate([polomerKvetinace+sirkaKapsle/2,polomerRohu,0])       // odecteni ctverce -> pulka obrazce
                        square([2*sirkaKapsle,2*polomerRohu], center = true);
                }
                
//.......................................................................................................
                
            linear_extrude(height=vyskaKapsle) rotate([0,0,vysecKapsle])            // znovu pro druhy bok ...
                difference(){
                    hull(){
                        translate([polomerKvetinace+polomerRohu,0,0])
                            circle(polomerRohu);
                        translate([polomerKvetinace+sirkaKapsle-polomerRohu,0,0])
                            circle(polomerRohu);
                        
                    }
                    hull(){
                        translate([polomerKvetinace+polomerRohu,0,0])
                            circle(polomerRohu-tloustkaSteny);
                        translate([polomerKvetinace+sirkaKapsle-polomerRohu,0,0])
                            circle(polomerRohu-tloustkaSteny);
                    }
                    
                    translate([polomerKvetinace+sirkaKapsle/2,-polomerRohu,0])
                        square([2*sirkaKapsle,2*polomerRohu], center = true);
                    }
                    
///////////////////////////////////////////////////////////////////////////////////////////////////////////////   
                    
            linear_extrude(height=tloustkaSteny) rotate([0,0,vysecKapsle])              // podlaha pod jednim bokem
                hull(){
                    translate([polomerKvetinace+polomerRohu,0,0])
                        circle(polomerRohu);
                    translate([polomerKvetinace+sirkaKapsle-polomerRohu,0,0])
                        circle(polomerRohu);                
                }
                
            linear_extrude(height=tloustkaSteny)                                       // podlaha pod druhym bokem
                hull(){
                    translate([polomerKvetinace+polomerRohu,0,0])
                        circle(polomerRohu);
                    translate([polomerKvetinace+sirkaKapsle-polomerRohu,0,0])
                        circle(polomerRohu);                        
                }
                    
        }
}










module dolniOblouk($fn = 100){
    difference(){                                           // valec nad trychtyrem
    translate([sirkaKapsle/2-polomerTrychtyre,0,-vyskaValceNadTrychtyrem])
        cylinder(r=polomerTrychtyre, h = vyskaValceNadTrychtyrem);
    translate([sirkaKapsle/2-polomerTrychtyre,0,-vyskaValceNadTrychtyrem-0.5])
        cylinder(r=polomerTrychtyre-tloustkaSteny, h = vyskaValceNadTrychtyrem+1);
    }

    difference(){                                           // trychtyr
        union(){
            translate([sirkaKapsle/2-polomerTrychtyre,0,-vyskaValceNadTrychtyrem])      // vnejsi cast
                scale([1,1,zplosteniTrychtyre])
                    sphere(polomerTrychtyre);
            translate([sirkaKapsle/2-polomerTrychtyre,0,-vyskaValceNadTrychtyrem-zplosteniTrychtyre*polomerTrychtyre])
                cylinder(r=polomerTrubicky, h = polomerTrychtyre*zplosteniTrychtyre);   // dolni lem
        }
        translate([sirkaKapsle/2-polomerTrychtyre,0,-vyskaValceNadTrychtyrem])      // odecteni vnitrku
            scale([1,1,0.5])
                sphere(polomerTrychtyre-tloustkaSteny);
        translate([sirkaKapsle/2-polomerTrychtyre,0,-vyskaValceNadTrychtyrem-zplosteniTrychtyre*polomerTrychtyre])   
            cylinder(r = polomerTrubicky-tloustkaStenTrubicky, h = polomerTrychtyre); // dira na trubicku
        translate([0,0,-vyskaValceNadTrychtyrem+10*polomerTrychtyre/2])
            cube(10*polomerTrychtyre, center = true);       // odecteni horni pulky
    }

    // oblouk u trychtyre
    translate([-polomerZahybuTrubicky+sirkaKapsle/2-polomerTrychtyre,0,-vyskaValceNadTrychtyrem-zplosteniTrychtyre*polomerTrychtyre])
        rotate([-90,0,0])
            rotate_extrude(angle=90)
                translate([polomerZahybuTrubicky,0,0])
                    difference(){
                        circle(polomerTrubicky);
                        circle(polomerTrubicky-tloustkaStenTrubicky);
                    }
    // druhy oblouk
    translate([polomerZahybuTrubicky+polomerTrubicky-sirkaKapsle/2,0,-vyskaValceNadTrychtyrem-zplosteniTrychtyre*polomerTrychtyre])
        rotate([-90,0,0])
            mirror([1,0,0])
                rotate_extrude(angle=90)
                    translate([polomerZahybuTrubicky,0,0])
                        difference(){
                            circle(polomerTrubicky);
                            circle(polomerTrubicky-tloustkaStenTrubicky);
                        }

      // kolma cast
      translate([-sirkaKapsle/2+polomerTrubicky,0,-(vyskaValceNadTrychtyrem+polomerTrychtyre*zplosteniTrychtyre)])
      difference(){
                cylinder(r= polomerTrubicky, h= vyskaValceNadTrychtyrem+polomerTrychtyre*zplosteniTrychtyre+vyskaKapsle);
                cylinder(r= polomerTrubicky-tloustkaStenTrubicky, h= vyskaValceNadTrychtyrem+polomerTrychtyre*zplosteniTrychtyre+vyskaKapsle);
      }
    
      // vodorovna cast
      translate([-sirkaKapsle/2+polomerZahybuTrubicky+polomerTrubicky,0,-vyskaValceNadTrychtyrem-polomerTrychtyre*zplosteniTrychtyre-polomerZahybuTrubicky])
          rotate([0,90,0])
              difference(){
                cylinder(r=polomerTrubicky, h=sirkaKapsle-polomerTrychtyre-2*polomerZahybuTrubicky-polomerTrubicky);
                cylinder(r=polomerTrubicky-tloustkaStenTrubicky, h=sirkaKapsle-polomerTrychtyre-2*polomerZahybuTrubicky-polomerTrubicky);
              }
}

module kapsleVyrezavaniDer(){
    difference(){                                                       // spodni dira na trychtyr
        kapsleZakladniTvar();
        translate([sirkaKapsle/2-polomerTrychtyre,0,-0.5])
            cylinder(r=polomerTrychtyre-tloustkaSteny, h = tloustkaSteny+1);
  
        translate([-sirkaKapsle/2+polomerTrubicky,0,0])                 // prutok trubicky casti steny
            cylinder(r=polomerTrubicky-tloustkaStenTrubicky, h = vyskaKapsle);
    }
}




kapsleVyrezavaniDer();
dolniOblouk();
hacek();
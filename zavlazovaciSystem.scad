sirkaKapsle = 90;
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
polomerDerVeSprse = 0.5;
pocetKruznicDer = 7;
uhelVnejsichDer = 50; // uhel vnejsiDira, stredKoule, vnejsiDira pred zplostenim!
polomerSprchy = 20;
vyskaKomolehoKuzele = 10;
uhelStrikaniVody = 60;
polomerOhybuSprchy = 10;
prodlouzeniSprchySvisle = 30;
prodlouzeniSprchySikme = 50;
vyskaNalevky = 50;
polomerNalevky = 40;
odriznutiNalevky = 1/4;
nalevkaPodOkrajem = 60;
tloustkaPrickyDole = 1;
vyskaPrickyDole = 5;
vnejsiPolomerObjimky = 3;
vnitriniPolomerObjimky = 1;  
tloustkaHorniPodlahy=3;
polomerSroubu = 2;
obrubaSirka = 3;
vyskaHornihoVika = 10;
rezervaProViko = .5;
polomerMotoru=18;
vyskaMotru=20;
polomerHridele=2;
vzdalenostSroubuMotoru = 12;
polomerSroubuNaMotor = 1.5;

vzdalenostPodlahyOdHornihoOkraje = 30;

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
                
module podlaha(okraj = 0, vyska=tloustkaSteny){  //vrati podlahu zmensenou o okraj
    translate([-polomerKvetinace-sirkaKapsle/2,0,0])    // posunuti a otoceni na stred...
        rotate([0,0,-vysecKapsle/2]){
             rotate_extrude(angle=vysecKapsle)                  // obdelni jako bocni prurez
                translate([polomerKvetinace+okraj,0,0])
                        square([sirkaKapsle-2*okraj, vyska]);
            linear_extrude(height=vyska) rotate([0,0,vysecKapsle])              // jeden bok
                hull(){
                    translate([polomerKvetinace+polomerRohu,0,0])
                        circle(polomerRohu-okraj);
                    translate([polomerKvetinace+sirkaKapsle-polomerRohu,0,0])
                        circle(polomerRohu-okraj);                
                }
            linear_extrude(height=vyska)                                       // druhy bok
                hull(){
                    translate([polomerKvetinace+polomerRohu,0,0])
                        circle(polomerRohu-okraj);
                    translate([polomerKvetinace+sirkaKapsle-polomerRohu,0,0])
                        circle(polomerRohu-okraj);                        
                }       
                
        }
}


module kapsleZakladniTvar($fn = 100){ 
    obrubaKPodlaze();
      difference(){
        podlaha(vyska=vyskaKapsle);
        translate([0,0,tloustkaSteny])
          podlaha(okraj=tloustkaSteny, vyska=vyskaKapsle);
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
        
        translate([-2*polomerNalevky*odriznutiNalevky+sirkaKapsle/2,0,-vyskaNalevky*(-tloustkaSteny/polomerNalevky+1)+vyskaKapsle-nalevkaPodOkrajem])                                                   // nalevka
            difference(){                                                 // odriznuti horniho okraje
                cylinder(r2=polomerNalevky, r1=0,h=vyskaNalevky);  
                translate([0,0,polomerNalevky+vyskaNalevky-vyskaNalevky*tloustkaSteny/polomerNalevky])
                    cube(2*polomerNalevky, center = true);
            }

    }
}



module sprchaDiry($fn = 100){

    for(i = [1 : pocetKruznicDer])
        for(j = [0 : 5])
            rotate([0, 0,60*j+(i%2) * 30])
                translate([i*(polomerSprchy-5*polomerDerVeSprse)/pocetKruznicDer,0,0])
                cylinder(r=polomerDerVeSprse, h = 2*polomerSprchy);
        
    
}


module hlavice($fn = 100){                      // hlavice sprchy
    zplosteniKoule = 0.25;              
    difference(){                               // duty elipsoid
        scale([1,1,zplosteniKoule])
            sphere(r = polomerSprchy);
        scale([1,1,zplosteniKoule])
            sphere(r = polomerSprchy-tloustkaStenTrubicky);
        
        translate([0,0,-polomerSprchy])             // odriznuti dolni pulky
            cube(2*polomerSprchy, center = true);

        sprchaDiry();   // vyriznutiDer
    }
    translate([0,0,-vyskaKomolehoKuzele])           // duty komoly kuzel
        difference(){
            cylinder(r1 = polomerTrubicky, r2=polomerSprchy, h = vyskaKomolehoKuzele);
            cylinder(r1 = polomerTrubicky-tloustkaStenTrubicky, r2=polomerSprchy-tloustkaStenTrubicky, h = vyskaKomolehoKuzele);
        }
    
}


module hadickaNadKapsli($fn = 100){
    translate([-polomerOhybuSprchy,0,prodlouzeniSprchySvisle])                  // oblouk
        rotate([90,0,0])
            rotate_extrude(angle=uhelStrikaniVody)
                translate([polomerOhybuSprchy,0,0])
                    difference(){
                        circle(r=polomerTrubicky);
                        circle(r=polomerTrubicky-tloustkaStenTrubicky);
                    }
                    
        difference(){                                                       // svisle prodlouzeni
           cylinder(r=polomerTrubicky, h = prodlouzeniSprchySvisle);
           cylinder(r=polomerTrubicky-tloustkaStenTrubicky, h = prodlouzeniSprchySvisle);    
        }
        
        translate([-polomerOhybuSprchy+polomerOhybuSprchy*cos(uhelStrikaniVody),0,prodlouzeniSprchySvisle+polomerOhybuSprchy*sin(uhelStrikaniVody)])
            rotate([0,-uhelStrikaniVody,0])                 // sikmeProdlouzeni
                difference(){
                   cylinder(r=polomerTrubicky, h = prodlouzeniSprchySikme);
                   cylinder(r=polomerTrubicky-tloustkaStenTrubicky, h = prodlouzeniSprchySikme);    
                }
    
}

module sprcha(){
       translate([-sirkaKapsle/2+polomerTrubicky,0,vyskaKapsle]){   // celkove posunuti na misto na kapsli
           hadickaNadKapsli();
           translate([polomerOhybuSprchy*(cos(uhelStrikaniVody)-1)-prodlouzeniSprchySikme*sin(uhelStrikaniVody),
                      0,
                      prodlouzeniSprchySvisle+polomerOhybuSprchy*sin(uhelStrikaniVody)+prodlouzeniSprchySikme*cos(uhelStrikaniVody)])
                            rotate([0,-uhelStrikaniVody,0]) // umisteni hlavice
                                translate([0,0,vyskaKomolehoKuzele])
                                    hlavice();
       }
}



module nalevka(){
    
        difference(){
            translate([-2*polomerNalevky*odriznutiNalevky+sirkaKapsle/2,0,-vyskaNalevky+vyskaKapsle-nalevkaPodOkrajem])
            cylinder(r2=polomerNalevky, r1=0,h=vyskaNalevky);                   // zakladni kuzel
            translate([-2*polomerNalevky*odriznutiNalevky+sirkaKapsle/2,0,-vyskaNalevky*(-tloustkaSteny/polomerNalevky+1)+vyskaKapsle-nalevkaPodOkrajem])
            cylinder(r2=polomerNalevky, r1=0,h=vyskaNalevky);                   // odecitany kuzel
            
            translate([-polomerKvetinace-sirkaKapsle/2,0,0])                    // odecteni kapsle
                rotate([0,0,-vysecKapsle/2])
                    rotate_extrude(angle=vysecKapsle) 
                        translate([polomerKvetinace,0,0])      
                                square([sirkaKapsle, vyskaKapsle]);
        }
  
    
}
           


module dolniUchyceniHridele($fn = 100){
    difference(){
        union(){
            translate([sirkaKapsle/2-polomerTrychtyre,0,-vyskaValceNadTrychtyrem/2])
                cube([2*polomerTrychtyre, tloustkaPrickyDole,vyskaPrickyDole], center = true);
            translate([sirkaKapsle/2-polomerTrychtyre,0,-vyskaValceNadTrychtyrem/2])
                cube([tloustkaPrickyDole, 2*polomerTrychtyre, vyskaPrickyDole], center = true);
            
            translate([sirkaKapsle/2-polomerTrychtyre,0,-vyskaValceNadTrychtyrem/2])
                cylinder(r=vnejsiPolomerObjimky+tloustkaPrickyDole, h = vyskaPrickyDole, center = true);
        }
        
        translate([sirkaKapsle/2-polomerTrychtyre,0,-vyskaValceNadTrychtyrem/2+tloustkaPrickyDole])
            cylinder(r=vnejsiPolomerObjimky, h=vyskaPrickyDole, center = true);
        
    }
}


module obrubaKPodlaze(){
    translate([0,0,-tloustkaSteny-vzdalenostPodlahyOdHornihoOkraje+vyskaKapsle])
    difference(){
        podlaha();
        podlaha(5);
    }

} 






module horniViko($fn = 100){
    translate([0,0,vyskaKapsle])
    difference(){
        union(){
            podlaha(okraj=0, vyska=tloustkaSteny);                              // horni uzaver
            translate([0,0,-vyskaHornihoVika])
                podlaha(okraj=rezervaProViko+tloustkaSteny, vyska=vyskaHornihoVika);          // to dole co se ma zasunout
        }
        translate([0,0,-vyskaHornihoVika-tloustkaSteny])                    
            podlaha(okraj=rezervaProViko+2*tloustkaSteny, vyska=vyskaHornihoVika);        // vykrojeni
        translate([-sirkaKapsle/2+polomerTrubicky,0,0])
            cylinder(r=polomerTrubicky+rezervaProViko,h=5*vyskaHornihoVika, center = true);     // vykrojeni na sprchu
        translate([-polomerKvetinace-sirkaKapsle/2+tloustkaSteny+rezervaProViko,0,0])
        rotate([0,0,-vysecHackuNaZaveseni/2-asin(rezervaProViko/polomerKvetinace)])
        rotate_extrude(angle=vysecHackuNaZaveseni+2*asin(rezervaProViko/polomerKvetinace))     // odkrojeni vnitrniho oblouku
        translate([polomerKvetinace-vyskaHornihoVika,0,0])
        square(vyskaHornihoVika);
        
    }
    translate([0,0,vyskaKapsle])
    difference(){
        translate([-sirkaKapsle/2+polomerTrubicky,0,-vyskaHornihoVika])
            cylinder(r=polomerTrubicky+rezervaProViko+tloustkaSteny,h=vyskaHornihoVika+tloustkaSteny);      // valec
        translate([-sirkaKapsle/2+polomerTrubicky,0,0])
            cylinder(r=polomerTrubicky+rezervaProViko,h=5*vyskaHornihoVika, center = true); // v nem znova vykrojeni na sprchu
        translate([-polomerKvetinace-sirkaKapsle/2,0,0])
            cylinder(r=polomerKvetinace+tloustkaSteny,h=vyskaHornihoVika);                            // oriznuti oblouku..
        translate([-polomerKvetinace-sirkaKapsle/2,0,-vyskaHornihoVika])
            cylinder(r=polomerKvetinace+rezervaProViko+tloustkaSteny,h=vyskaHornihoVika);   
        translate([-polomerKvetinace-sirkaKapsle/2+tloustkaSteny+rezervaProViko,0,0])   // odkrojeni vnitrniho oblouku
        rotate([0,0,-vysecHackuNaZaveseni/2-asin(rezervaProViko/polomerKvetinace)])
        rotate_extrude(angle=vysecHackuNaZaveseni+2*asin(rezervaProViko/polomerKvetinace))
        translate([polomerKvetinace-vyskaHornihoVika,0,0])
        square(vyskaHornihoVika);
     
    }
    



   


}







module horniPatro(){
    translate([0,0,vyskaKapsle-vzdalenostPodlahyOdHornihoOkraje]){
    difference(){
        union(){
            podlaha(okraj=rezervaProViko+tloustkaSteny, vyska=tloustkaHorniPodlahy);
            translate([sirkaKapsle/2-polomerTrychtyre,0,tloustkaHorniPodlahy])                 // kolem motoru
                cylinder(r=polomerMotoru+tloustkaSteny, h = vyskaMotru);
        }
        translate([sirkaKapsle/2-polomerTrychtyre,0,tloustkaHorniPodlahy])                     // motor
            cylinder(r=polomerMotoru, h = vyskaMotru);
        
        
        translate([sirkaKapsle/2-polomerTrychtyre,0,0])
            cylinder(r=polomerHridele, h = tloustkaHorniPodlahy);       // hridel
        translate([sirkaKapsle/2-polomerTrychtyre,vzdalenostSroubuMotoru/2,0])
            cylinder(r=polomerSroubuNaMotor, h = tloustkaHorniPodlahy);       // sroubNaMotor1
                translate([sirkaKapsle/2-polomerTrychtyre,-vzdalenostSroubuMotoru/2,0])
            cylinder(r=polomerSroubuNaMotor, h = tloustkaHorniPodlahy);       // sroubNaMotor2
    
        
        translate([-polomerKvetinace-sirkaKapsle/2,0,0])    
            rotate([0,0,vysecKapsle/2])
                translate([polomerKvetinace+polomerRohu,0,0])
                    cylinder(r=polomerSroubu,h = tloustkaHorniPodlahy);     // dira vpravo u kvetinace
     
        translate([-polomerKvetinace-sirkaKapsle/2,0,0])    
            rotate([0,0,-vysecKapsle/2])
                translate([polomerKvetinace+polomerRohu,0,0])
                    cylinder(r=polomerSroubu,h = tloustkaHorniPodlahy);     // dira vlevo u kvetinace
        
        translate([-polomerKvetinace-sirkaKapsle/2,0,0])    
            rotate([0,0,vysecKapsle/2])
                translate([polomerKvetinace-polomerRohu+sirkaKapsle,0,0])
                    cylinder(r=polomerSroubu,h = tloustkaHorniPodlahy);     // dira vpravo dal od kvetinace
        
        translate([-polomerKvetinace-sirkaKapsle/2,0,0])    
            rotate([0,0,-vysecKapsle/2])
                translate([polomerKvetinace-polomerRohu+sirkaKapsle,0,0])
                    cylinder(r=polomerSroubu,h = tloustkaHorniPodlahy);     // dira vlevo dal od kvetinace
            
        
    }


}







}




horniPatro();
dolniUchyceniHridele();
nalevka();
sprcha();
kapsleVyrezavaniDer();
dolniOblouk();
hacek();
kapsleVyrezavaniDer();
horniViko();















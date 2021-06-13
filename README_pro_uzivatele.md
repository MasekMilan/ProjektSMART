# Příručka pro použití zařízení _Zavlažovač kytek_

## Úvod
- Každému z nás už se jistě aspoň jednou stalo, že kytky zapomněl zalít a květina uschla.
- Přesně k tomu je tu _Zavlažovač kytek_, který hlídá vlhkost v půdě, v které je rostlina zasazena.

## Konstrukční řešení
- Zařízení je vyrobeno pomocí 3D tisku a dá se modifikovat pro určitý typ květináče
- Zařízení se dá snadno na květináč zavěsit a nemusí se k němu nic připojovat.
- Chod je bezúdržbový. jen je nutné doplňovat baterky do motoru a vodu do nádržky.

### Venkovní pohled
<p align="center">
    <img src="pictures/pozice0.png" width="300"/> <img src="pictures/pozice1.png"  width="300"/> <img src="pictures/pozice2.png" width="300"/>
</p>

- Ze strany vyčuhuje trychtýř pro nalévání vody. Voda se pak plní do nádržky.
- Na horní straně je pak vidět konec konvice na zalévání, z které tato voda proudí do půdy.

### Vnitřní pohled
<p align="center">
    <img src="pictures/pozice4.png"  width="300"/> <img src="pictures/pozice5.png"  width="300"/> <img src="pictures/pozice6.png" width="300"/>
</p>

- Pod horním víkem se chovává technická část zařízení.
- Toto víko se dá snadno odšroubovat.
- Nachází se tam: 
  - přihrádka pro baterie pro jejich snadnou výměnu
  - Arduino pro řízení celého systému
  - motor, který pohání vrtuli

### Funkce motoru
<p align="center">
    <img src="pictures/pozice7.png"  width="300"/> <img src="pictures/pozice8.png"  width="300"/> <img src="pictures/pozice3.png" width="300"/>
</p>

- Motor, kterému dává signály Arduino, pohání vrtuli.
- Vrtule je na spodu nádržky na vodu a žene vodu trubicí, která vede pod nádržkou. 
- Díky podtlaku se tato voda dostane až do konvice na zalévání a voda se začne rozprašovat po povrchu půdy.

## Stručný popis fungování
- Pokud vlhkost v půdě klesne pod danou mez, senzor vlhkosti vyšle signály do Arduina.
- Arduino zapne motor, který je připojen na vrtuli.
- Vrtule se roztočí a žene vodu seměrem vzůhuru do konvice, která vodu rozmístí po povrchu půdy.
- Až bude vlhkost v půdě opět dobrá, senzory vlhkosti vyšlou signály Arduinu a to vypne motor.
- Vrtule se pak tedy točí do té doby, než je vlhkost v půdě opět v normálu.

## Instalace
- Zařízení je 

## Použití
- Zařízení se dá vytisknout na 3D tiskárně a je možno změnit si rozměry.
- Využít se dá u všech domácích rostlin.
- Je možno takové zařízení využít i ve velkých sklenících

## Údržba
- Provoz je bezúdržbový.
- Po instalaci není třeba dělat nic


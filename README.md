### Tema 2 PCLP2 - Plesa Marian Cosmin

# Task 1 - Permissions 

Am shiftat primii 24 biti pentru a ramane cu cei 8 (id furnica)
si am folosit acest numar ca un contor/index, am inmultit cu 4 pentru ca
fiecare intrare din acesta este (dword). M-am folosit de operatiile push/pop
pentru a pastra valoarea originala a lui eax. Acel AND l-am facut pentru a
ramane cu cei 24 biti de jos (practic de la dr la stanga), precum in poza
oferita in enuntul temei. La fel ca mai sus, am folosit push si pop pentru
a pastra valoarea registrului eax. Dupa fac acel AND si verific rezultatul si
il pun la adresa ceruta.

# Task 2 - EMPTY

# Task 3 - Treyfer

Prima parte este cea de criptare in care am aplicat algoritmul dat in cerinta
temei si in plus am tratat cazul in care se ajunge pe ultimul byte si sar la
ending dupa.

A doua parte a fost cea de decriptare in care am realizat algoritmul precum in cerinta
si am tratat din nou cazurile last si not last separat.

# Task 4 - Labyrinth

Am inceput prin a da push registrelor eax si ebx pentru a le pastra valorea,
deoarece in aceste registre trebuia sa introducem rezultatul final. Tot pe
eax si ebx i-am luat drept contori, deoarece nu le stric valoarea, practic
am doi registrii in plus liberi. Am si 2 variabile globale care reprezinta
numarul de coloane si de linii. Incep cu rezolvarea labirintului accesand
element din matrice si dupa ce il accesez il marchez cu '1' ca fiind vizitat.
Fac si comparatie sa vad unde ma aflu si daca e cazul sa merg in out. Daca nu,
verific la dreapta (am descris in comentariile codului operatiile), dupa stanga,
jos si sus. Am si functiile efective de move in caz ca am gasit liber. La final
mut eax si ebx in ecx si edx, le dau pop pentru ca acestea sa reprezinte valorile
pe care trebuie sa le returnam, si dupa pun registrii corespunzatori.



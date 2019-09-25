DROP TABLE detailsemprunts;
DROP TABLE emprunts;
DROP TABLE membres;
DROP TABLE exemplaires;
DROP TABLE ouvrages;
DROP TABLE genres;


create table genres(
code char(5) constraint pk_genres primary key,
libelle varchar(80) not null);


create table ouvrages(
isbn numeric(10) constraint pk_ouvrages primary key,
titre varchar(200)not null,
auteur varchar(80),
genre char(5) not null constraint fk_ouvrages_genres references genres(code),
editeur varchar(80));


create table exemplaires(
isbn numeric(10),
numero int,
etat char(5),
constraint pk_exemplaires primary key(isbn, numero),
constraint fk_exemplaires_ouvrages foreign key(isbn) references ouvrages(isbn),
constraint ck_exemplaires_etat check (etat in('NE','BO','MO','MA')) );


create table membres(
numero int constraint pk_membres primary key identity,
nom varchar(80) not null,
prenom varchar(80) not null,
adresse varchar(200) not null,
telephone char(10) not null,
adhesion date not null,
duree int not null,
constraint ck_membres_duree check (duree>=0));


create table emprunts(
numero int constraint pk_emprunts primary key,
membre int constraint fk_emprunts_membres references membres(numero),
creele date default GETDATE());


create table detailsemprunts(
emprunt int constraint fk_details_emprunts references emprunts(numero),
numero int,
isbn numeric(10),
exemplaire int,
rendule date,
constraint pk_detailsemprunts primary key (emprunt, numero),
constraint fk_detailsemprunts_exemplaires foreign key(isbn, exemplaire) references exemplaires(isbn, numero));

--INSERTION GENRES
insert into genres(code, libelle) values ('REC','Récit');
insert into genres(code, libelle) values ('POL','Policier');
insert into genres(code, libelle) values ('BD','Bande Dessinée');
insert into genres(code, libelle) values ('INF','Informatique');
insert into genres(code, libelle) values ('THE','Théâtre');
insert into genres(code, libelle) values ('ROM','Roman');
--INSERTION OUVRAGES
insert into ouvrages (isbn, titre, auteur, genre, editeur) 
values (2203314168, 'LEFRANC-L''ultimatum', 'Martin, Carin', 'BD', 'Casterman');
insert into ouvrages (isbn, titre, auteur, genre, editeur) 
values (2746021285, 'HTML entraînez-vous pour maîtriser le code source', 'Luc Van Lancker', 'INF', 'ENI');
insert into ouvrages (isbn, titre, auteur, genre, editeur) 
values (2746026090, ' Oracle 12c SQL, PL/SQL, SQL*Plus', 'J. Gabillaud', 'INF', 'ENI');
insert into ouvrages (isbn, titre, auteur, genre, editeur) 
values (2266085816, 'Pantagruel', 'François RABELAIS', 'ROM', 'POCKET');
insert into ouvrages (isbn, titre, auteur, genre, editeur) 
values (2266091611, 'Voyage au centre de la terre', 'Jules Verne', 'ROM', 'POCKET');
insert into ouvrages (isbn, titre, auteur, genre, editeur) 
values (2253010219, 'Le crime de l''Orient Express', 'Agatha Christie', 'POL', 'Livre de Poche');
insert into ouvrages (isbn, titre, auteur, genre, editeur) 
values (2070400816, 'Le Bourgeois gentilhomme', 'Moliere', 'THE', 'Gallimard');
insert into ouvrages (isbn, titre, auteur, genre, editeur) 
values (2070367177, 'Le curé de Tours', 'Honoré de Balzac', 'ROM', 'Gallimard');
insert into ouvrages (isbn, titre, auteur, genre, editeur) 
values (2877065073, 'La gloire de mon père', 'Marcel Pagnol', 'ROM', 'Fallois');
insert into ouvrages (isbn, titre, auteur, genre, editeur) 
values (2020549522, ' L''aventure des manuscrits de la mer morte ', default, 'REC', 'Seuil');
insert into ouvrages (isbn, titre, auteur, genre, editeur) 
values (2038704015, 'De la terre à la lune', 'Jules Verne', 'ROM', 'Larousse');
insert into ouvrages (isbn, titre, auteur, genre, editeur) 
values (2409015867, 'Kotlin', 'Anthony Cosson', 'INF', 'ENI');
insert into ouvrages (isbn, titre, auteur, genre, editeur) 
values (2409008153, 'JEE', 'Thierry Richard', 'INF', 'ENI');
insert into ouvrages (isbn, titre, auteur, genre, editeur) 
values (2253006327, ' Vingt mille lieues sous les mers ', 'Jules Verne', 'ROM', 'LGF');
insert into ouvrages (isbn, titre, auteur, genre, editeur) 
values (2080720872, 'Boule de suif', 'Guy de Maupassant', 'REC', 'Flammarion');
--INSERTION EXEMPLAIRES
insert into exemplaires(isbn, numero, etat) select isbn, 1,'BO' from ouvrages;
insert into exemplaires(isbn, numero, etat) select isbn, 2,'MO' from ouvrages;
delete from exemplaires where isbn=2746021285 and numero=2;
update exemplaires set etat='MO' where isbn=2203314168 and numero=1;
update exemplaires set etat='BO' where isbn=2203314168 and numero=2;
insert into exemplaires(isbn, numero, etat) values (2203314168,3,'NE');
--INSERTION MEMBRES
insert into membres values ('ALBERT', 'Anne', '13 rue des alpes', '0601020304', GETDATE()-60, 1);
insert into membres values ('BERNAUD', 'Barnabé', '6 rue des bécasses', '0602030105', GETDATE()-10, 3);
insert into membres values ('CUVARD', 'Camille', '52 rue des cerisiers', '0602010509', GETDATE()-100, 6);
insert into membres values ('DUPOND', 'Daniel', '11 rue des daims', '0610236515', GETDATE()-250, 12);
insert into membres values ('EVROUX', 'Eglantine', '34 rue des elfes', '0658963125', GETDATE()-150, 6);
insert into membres values ('FREGEON', 'Fernand', '11 rue des Francs', '0602036987', GETDATE()-400, 6);
insert into membres values ('GORIT', 'Gaston', '96 rue de la glacerie ', '0684235781', GETDATE()-150, 1);
insert into membres values ('HEVARD', 'Hector', '12 rue haute', '0608546578', GETDATE()-250, 12);
insert into membres values ('INGRAND', 'Irène', '54 rue des iris', '0605020409', GETDATE()-50, 12);
insert into membres values ('JUSTE', 'Julien', '5 place des Jacobins', '0603069876', GETDATE()-100, 6);
--INSERTION EMPRUNTS
insert into emprunts(numero, membre, creele) values(1,1,GETDATE()-200);
insert into emprunts(numero, membre, creele) values(2,3,GETDATE()-190);
insert into emprunts(numero, membre, creele) values(3,4,GETDATE()-180);
insert into emprunts(numero, membre, creele) values(4,1,GETDATE()-170);
insert into emprunts(numero, membre, creele) values(5,5,GETDATE()-160);
insert into emprunts(numero, membre, creele) values(6,2,GETDATE()-150);
insert into emprunts(numero, membre, creele) values(7,4,GETDATE()-140);
insert into emprunts(numero, membre, creele) values(8,1,GETDATE()-130);
insert into emprunts(numero, membre, creele) values(9,9,GETDATE()-120);
insert into emprunts(numero, membre, creele) values(10,6,GETDATE()-110);
insert into emprunts(numero, membre, creele) values(11,1,GETDATE()-100);
insert into emprunts(numero, membre, creele) values(12,6,GETDATE()-90);
insert into emprunts(numero, membre, creele) values(13,2,GETDATE()-80);
insert into emprunts(numero, membre, creele) values(14,4,GETDATE()-70);
insert into emprunts(numero, membre, creele) values(15,1,GETDATE()-60);
insert into emprunts(numero, membre, creele) values(16,3,GETDATE()-50);
insert into emprunts(numero, membre, creele) values(17,1,GETDATE()-40);
insert into emprunts(numero, membre, creele) values(18,5,GETDATE()-30);
insert into emprunts(numero, membre, creele) values(19,4,GETDATE()-20);
insert into emprunts(numero, membre, creele) values(20,1,GETDATE()-10);
--INSERTION DETAILS
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(1,1,2038704015,1,GETDATE()-195);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(1,2,2070367177,2,GETDATE()-190);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(2,1,2080720872,1,GETDATE()-180);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(2,2,2203314168,1,GETDATE()-179);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(3,1,2038704015,1,GETDATE()-170);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(4,1,2203314168,2,GETDATE()-155);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(4,2,2080720872,1,GETDATE()-155);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(4,3,2266085816,1,GETDATE()-159);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(5,1,2038704015,1,GETDATE()-140);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(6,1,2266085816,2,GETDATE()-141);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(6,2,2080720872,2,GETDATE()-130);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(6,3,2746021285,1,GETDATE()-133);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(7,1,2070367177,2,GETDATE()-100);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(8,1,2080720872,1,GETDATE()-116);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(9,1,2038704015,1,GETDATE()-100);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(10,1,2080720872,2,GETDATE()-107);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(10,2,2746026090,1,GETDATE()-78);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(11,1,2746021285,1,GETDATE()-81);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(12,1,2203314168,1,GETDATE()-86);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(12,2,2038704015,1,GETDATE()-60);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(13,1,2070367177,1,GETDATE()-65);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(14,1,2266091611,1,GETDATE()-66);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(15,1,2070400816,1,GETDATE()-50);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(16,1,2253010219,2,GETDATE()-41);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(16,2,2070367177,2,GETDATE()-41);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(17,1,2877065073,2,GETDATE()-36);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(18,1,2070367177,1,GETDATE()-14);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(19,1,2746026090,1,GETDATE()-12);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(20,1,2266091611,1,default);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(20,2,2253010219,1,default);

alter table emprunts add etat char(2) default 'EC';

alter table emprunts add constraint ck_emprunts_etat check (etat in ('EC','RE'));

Update emprunts set etat='RE' where etat='EC' and numero not in (select emprunt from detailsemprunts where rendule is null);

Insert into ouvrages (isbn, titre, auteur, genre, editeur) values (2080703234, 'Cinq semaines en ballon', 'Jules Verne', 'ROM', 'Flammarion');

insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(7,2,2038704015,1,GETDATE()-136);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(8,2,2038704015,1,GETDATE()-127);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(11,2,2038704015,1,GETDATE()-95);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(15,2,2038704015,1,GETDATE()-54);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(16,3,2038704015,1,GETDATE()-43);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(17,2,2038704015,1,GETDATE()-36);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(18,2,2038704015,1,GETDATE()-24);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(19,2,2038704015,1,GETDATE()-13);
insert into detailsemprunts(emprunt, numero, isbn, exemplaire, rendule) values(20,3,2038704015,1,GETDATE()-3);

INSERT INTO exemplaires(isbn, numero, etat) VALUES (2203314168,4,'MA');
INSERT INTO exemplaires(isbn, numero, etat) VALUES (2746021285,3,'MA');
INSERT INTO exemplaires(isbn, numero, etat) VALUES (2070367177,4,'NE');
INSERT INTO exemplaires(isbn, numero, etat) VALUES (2266085816,4,'NE');
INSERT INTO exemplaires(isbn, numero, etat) VALUES (2080720872,4,'NE');

INSERT INTO membres VALUES('Onette','Camille','1 rue des jeux de mots pourris 35000','0625398651',GETDATE()-2000,1);
INSERT INTO membres VALUES('Zolle','Camille','2 rue des jeux de mots pourris 35000','0625638651',GETDATE()-2000,1);
INSERT INTO membres VALUES('Haba','Bart','18 rue des jeux de mots pourris 35000','0625398981',GETDATE()-2482,1);
INSERT INTO membres VALUES('Hannibal ','Farid','91 rue des jeux de mots pourris 35000','0621298651',GETDATE()-2536,1);
INSERT INTO membres VALUES('Don Marcel','Eddy','12 rue des jeux de mots pourris 35000','0625365651',GETDATE()-2365,1);
--
INSERT INTO emprunts VALUES(1000,11,GETDATE()-1000,'EC');
INSERT INTO emprunts VALUES(1001,11,GETDATE()-1100,'RE');
INSERT INTO emprunts VALUES(1002,11,GETDATE()-1200,'RE');
INSERT INTO emprunts VALUES(1003,11,GETDATE()-1300,'RE');
INSERT INTO emprunts VALUES(1004,11,GETDATE()-1400,'RE');
INSERT INTO emprunts VALUES(1005,11,GETDATE()-1500,'RE');

INSERT INTO emprunts VALUES(1006,12,GETDATE()-1150,'RE');
INSERT INTO emprunts VALUES(1007,12,GETDATE()-1250,'RE');
INSERT INTO emprunts VALUES(1008,12,GETDATE()-1350,'RE');
INSERT INTO emprunts VALUES(1009,12,GETDATE()-1450,'RE');
INSERT INTO emprunts VALUES(1010,12,GETDATE()-1550,'RE');


INSERT INTO detailsemprunts VALUES(1000,1,2070367177,4,null);
INSERT INTO detailsemprunts VALUES(1000,2,2203314168,4,null);
INSERT INTO detailsemprunts VALUES(1000,3,2266085816,4,null);
INSERT INTO detailsemprunts VALUES(1000,4,2080720872,4,null);

INSERT INTO detailsemprunts VALUES(1006,1,2070367177,4,null);
INSERT INTO detailsemprunts VALUES(1006,2,2203314168,4,null);
INSERT INTO detailsemprunts VALUES(1006,3,2266085816,4,null);
INSERT INTO detailsemprunts VALUES(1006,4,2080720872,4,null);

INSERT INTO membres VALUES('LOMOBO','Laurent','31 rue des lilas','0615263114',GETDATE()-1000,1);
INSERT INTO membres VALUES('Cosson','Anthony','31 rue des oliviers','0651865319',GETDATE()-1000,3);

INSERT INTO emprunts VALUES(1011,17,GETDATE()-950,'RE');
INSERT INTO emprunts VALUES(1012,17,GETDATE()-900,'RE');
INSERT INTO emprunts VALUES(1013,17,GETDATE()-800,'RE');
INSERT INTO emprunts VALUES(1014,17,GETDATE()-750,'RE');

INSERT INTO detailsemprunts VALUES(1011,1,2070367177,4,GETDATE()-930);
INSERT INTO detailsemprunts VALUES(1011,2,2203314168,4,GETDATE()-930);
INSERT INTO detailsemprunts VALUES(1011,3,2266085816,4,GETDATE()-930);
INSERT INTO detailsemprunts VALUES(1011,4,2080720872,4,GETDATE()-930);

INSERT INTO detailsemprunts VALUES(1012,1,2070367177,4,GETDATE()-830);
INSERT INTO detailsemprunts VALUES(1012,2,2203314168,4,GETDATE()-830);
INSERT INTO detailsemprunts VALUES(1012,3,2266085816,4,GETDATE()-830);
INSERT INTO detailsemprunts VALUES(1012,4,2080720872,4,GETDATE()-830);

INSERT INTO detailsemprunts VALUES(1013,1,2070367177,4,GETDATE()-780);
INSERT INTO detailsemprunts VALUES(1013,2,2203314168,4,GETDATE()-780);
INSERT INTO detailsemprunts VALUES(1013,3,2266085816,4,GETDATE()-780);
INSERT INTO detailsemprunts VALUES(1013,4,2080720872,4,GETDATE()-780);

INSERT INTO detailsemprunts VALUES(1014,1,2070367177,4,GETDATE()-710);
INSERT INTO detailsemprunts VALUES(1014,2,2203314168,4,GETDATE()-710);
INSERT INTO detailsemprunts VALUES(1014,3,2266085816,4,GETDATE()-710);
INSERT INTO detailsemprunts VALUES(1014,4,2080720872,4,GETDATE()-710);


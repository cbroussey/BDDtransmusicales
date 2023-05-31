DROP SCHEMA IF EXISTS transmusicales CASCADE;
CREATE SCHEMA transmusicales;
SET SCHEMA 'transmusicales';

CREATE TABLE _annee
(
   an INT,
   CONSTRAINT annee_pk PRIMARY KEY(an)
);

CREATE TABLE _edition
(
   nom_edition VARCHAR(50),
   annee_edition INT NOT NULL,
   CONSTRAINT edition_pk PRIMARY KEY(nom_edition),
   CONSTRAINT edition_fk FOREIGN KEY(annee_edition) REFERENCES _annee(an)
);

CREATE TABLE _type_musique
(
   type_m VARCHAR(30),
   CONSTRAINT type_musique_pk PRIMARY KEY(type_m)
);

CREATE TABLE _concert
(
   no_concert VARCHAR(10),
   nom_edition VARCHAR(50) NOT NULL,
   titre VARCHAR(50) NOT NULL,
   resume VARCHAR(200),
   genre_concert VARCHAR(30) NOT NULL,
   duree INT NOT NULL,
   tarif FLOAT NOT NULL,
   CONSTRAINT concert_pk PRIMARY KEY(no_concert),
   CONSTRAINT concert_fk1 FOREIGN KEY(nom_edition) REFERENCES _edition(nom_edition),
   CONSTRAINT concert_fk2 FOREIGN KEY(genre_concert) REFERENCES _type_musique(type_m)
);

CREATE TABLE _pays
(
   nom_p VARCHAR(20),
   CONSTRAINT pays_pk PRIMARY KEY(nom_p)
);

CREATE TABLE _ville
(
   nom_v VARCHAR(30),
   nom_pays VARCHAR(20) NOT NULL,
   CONSTRAINT ville_pk PRIMARY KEY(nom_v),
   CONSTRAINT ville_fk FOREIGN KEY(nom_pays) REFERENCES _pays(nom_p)
);

CREATE TABLE _lieu
(
   id_lieu VARCHAR(10),
   nom_lieu VARCHAR(30) NOT NULL,
   nom_ville VARCHAR(30) NOT NULL,
   accesPMR BOOLEAN NOT NULL,
   capacite_max INT NOT NULL,
   type_lieu VARCHAR(20) NOT NULL,
   CONSTRAINT lieu_pk PRIMARY KEY(id_lieu),
   CONSTRAINT lieu_fk FOREIGN KEY(nom_ville) REFERENCES _ville(nom_v)
);

CREATE TABLE _groupe_artiste
(
   id_groupe_artiste VARCHAR(10),
   nom_groupe_artiste VARCHAR(30) NOT NULL,
   pays_origine VARCHAR(20) NOT NULL,
   annee_debuts INT NOT NULL,
   premier_album INT NOT NULL,
   site_web VARCHAR(50),
   CONSTRAINT groupe_artiste_pk PRIMARY KEY(id_groupe_artiste),
   CONSTRAINT groupe_artiste_fk1 FOREIGN KEY(pays_origine) REFERENCES _pays(nom_p),
   CONSTRAINT groupe_artiste_fk2 FOREIGN KEY(annee_debuts) REFERENCES _annee(an),
   CONSTRAINT groupe_artiste_fk3 FOREIGN KEY(premier_album) REFERENCES _annee(an)
);

CREATE TABLE _type_principal
(
  id_groupe VARCHAR(10),
  genre VARCHAR(30),
  CONSTRAINT type_principal_pk PRIMARY KEY(id_groupe, genre),
  CONSTRAINT type_principal_fk1 FOREIGN KEY(id_groupe) REFERENCES _groupe_artiste(id_groupe_artiste),
  CONSTRAINT type_principal_fk2 FOREIGN KEY(genre) REFERENCES _type_musique(type_m)
);

CREATE TABLE _type_ponctuel
(
  id_groupe VARCHAR(10),
  genre VARCHAR(30),
  CONSTRAINT type_ponctuel_pk PRIMARY KEY(id_groupe, genre),
  CONSTRAINT type_ponctuel_fk1 FOREIGN KEY(id_groupe) REFERENCES _groupe_artiste(id_groupe_artiste),
  CONSTRAINT type_ponctuel_fk2 FOREIGN KEY(genre) REFERENCES _type_musique(type_m)
);

CREATE TABLE _representation
(
   numero_representation VARCHAR(10),
   numero_concert VARCHAR(10) NOT NULL,
   id_endroit VARCHAR(10) NOT NULL,
   id_groupe VARCHAR(10) NOT NULL,
   heure VARCHAR(5) NOT NULL,
   date_representation VARCHAR(10) NOT NULL,
   CONSTRAINT representation_pk PRIMARY KEY(numero_representation),
   CONSTRAINT representation_fk1 FOREIGN KEY(numero_concert) REFERENCES _concert(no_concert),
   CONSTRAINT representation_fk2 FOREIGN KEY(id_endroit) REFERENCES _lieu(id_lieu),
   CONSTRAINT representation_fk3 FOREIGN KEY(id_groupe) REFERENCES _groupe_artiste(id_groupe_artiste)
   
);

CREATE TABLE _formation
(
   libelle_formation VARCHAR(30),
   CONSTRAINT formation_pk PRIMARY KEY(libelle_formation)
);

CREATE TABLE _a_pour
(
  id_groupe VARCHAR(10),
  nom_formation VARCHAR(30),
  CONSTRAINT a_pour_pk PRIMARY KEY(id_groupe, nom_formation),
  CONSTRAINT a_pour_fk1 FOREIGN KEY(id_groupe) REFERENCES _groupe_artiste(id_groupe_artiste),
  CONSTRAINT a_pour_fk2 FOREIGN KEY(nom_formation) REFERENCES _formation(libelle_formation)
);

COMMIT;

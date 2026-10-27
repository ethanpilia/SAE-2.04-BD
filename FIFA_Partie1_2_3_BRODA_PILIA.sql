/*==============================================================*/
/* Nom de SGBD :  ORACLE Version 11g                            */
/* Date de creation : 13/05/2026                                */
/*==============================================================*/

/*==============================================================*/
/* Table : CATEGORIE                                            */
/*==============================================================*/
create table CATEGORIE 
(
   numCatg              INTEGER              not null,
   libCatg              VARCHAR2(50)         not null,
   prix                 INTEGER,

   constraint PK_CATEGORIE primary key (numCatg)
);

/*==============================================================*/
/* Table : PHASE                                                */
/*==============================================================*/
create table PHASE 
(
   cdPh                 CHAR(2)              not null,
   libPh                VARCHAR2(50)         not null,
   nbMatch              INTEGER,
   typePh               INTEGER              default 2,
   "desc"               VARCHAR2(50),

   constraint PK_PHASE primary key (cdPh),
   constraint CK_PHASE_NBMATCH check (nbMatch between 1 and 64),
   constraint CK_PHASE_TYPEPH check (typePh in (1, 2))
);

/*==============================================================*/
/* Table : EQUIPE                                               */
/*==============================================================*/
create table EQUIPE 
(
   cdEq                 CHAR(3)              not null,
   cdPays               CHAR(3),
   libEq                VARCHAR2(50)         not null,
   groupe               CHAR(1),
   niveau               INTEGER,
   nbTitres             INTEGER,
   selectionneur        VARCHAR2(50),

   constraint PK_EQUIPE primary key (cdEq),
   constraint FK_EQUIPE_APPARTENI_PAYS foreign key (cdPays)
      references PAYS (cdPays),
   constraint CK_EQUIPE_GROUPE check (groupe in ('A','B','C','D','E','F','G','H'))
);

/*==============================================================*/
/* Table : STADE                                                */
/*==============================================================*/
create table STADE 
(
   cdStd                CHAR(3)              not null,
   cdPays               CHAR(3),
   nomStd               VARCHAR2(50)         not null,
   typeStd              INTEGER,
   capacite             INTEGER,
   longitude            NUMBER(11,8),
   latitude             NUMBER(11,8),

   constraint PK_STADE primary key (cdStd),
   constraint FK_STADE_SE_SITUER_PAYS foreign key (cdPays)
      references PAYS (cdPays),
   constraint CK_STADE_TYPESTD check (typeStd in (1, 2, 3))
);

/*==============================================================*/
/* Table : MATCH                                                */
/*==============================================================*/
create table MATCH 
(
   numMatch             INTEGER              not null,
   cdStd                CHAR(3),
   cdEq1                CHAR(3),
   cdPh                 CHAR(2),
   cdEq2                CHAR(3),
   dateMatch            DATE,
   scoreEq1             INTEGER,
   scoreEq2             INTEGER,

   constraint PK_MATCH primary key (numMatch),
   constraint FK_MATCH_DEROULER_PHASE foreign key (cdPh)
      references PHASE (cdPh),
   constraint FK_MATCH_JOUER1_EQUIPE foreign key (cdEq2)
      references EQUIPE (cdEq),
   constraint FK_MATCH_JOUER2_EQUIPE foreign key (cdEq1)
      references EQUIPE (cdEq),
   constraint FK_MATCH_SE_PASSE_STADE foreign key (cdStd)
      references STADE (cdStd),
   constraint CK_MATCH_EQUIPE_DIFFERENTE check (cdEq1 <> cdEq2)
);

/*==============================================================*/
/* Table : ACHAT                                                */
/*==============================================================*/
create table ACHAT 
(
   numSup               INTEGER              not null,
   numMatch             INTEGER              not null,
   numCatg              INTEGER              not null,
   dateAchat            DATE                 not null,
   nbPlaces             INTEGER,
   modeReglt            CHAR(3),

   constraint PK_ACHAT primary key (numSup, numMatch, numCatg, dateAchat),
   constraint FK_ACHAT_CONCERNER_CATEGORI foreign key (numCatg)
      references CATEGORIE (numCatg),
   constraint FK_ACHAT_EFFECTUER_SUPPORTE foreign key (numSup)
      references SUPPORTER (numSup),
   constraint FK_ACHAT_REGARDER_MATCH foreign key (numMatch)
      references MATCH (numMatch),
   constraint CK_ACHAT_MODEREGLT check (modeReglt in ('CB','CHQ','ESP'))
);
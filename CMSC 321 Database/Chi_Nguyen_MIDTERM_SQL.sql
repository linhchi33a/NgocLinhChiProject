CREATE TABLE MAP(
	id_map INT(2) NOT NULL,
    name_map VARCHAR(255),
    popularity_map VARCHAR(20),
    PRIMARY KEY(id_map)
);

CREATE TABLE MODES(
	id_mode INT(2) NOT NULL,
    name_mode VARCHAR(255),
    populartity_mode VARCHAR(20),
    availible BOOLEAN,
    map_id INT(2) NOT NULL,
    PRIMARY KEY(id_mode),
    FOREIGN KEY(map_id) REFERENCES MAP(id_map)
);


CREATE TABLE BASIC_STATS(
	id_basic INT(2) NOT NULL,
    health INT(4),
    armor INT(4),
    magic_resist INT(4),
    move_speed INT(4),
    mana INT(4),
    PRIMARY KEY(id_basic)
);

CREATE TABLE LORE(
	id_lore INT(2) NOT NULL,
    region VARCHAR(255),
    WEAPON VARCHAR(255),
    gender VARCHAR(1),
    race VARCHAR(255),
    PRIMARY KEY(id_lore)
);


CREATE TABLE ABLILITIES(
	id_ablilities INT(2) NOT NULL,
    Passive VARCHAR(10000),
    Q VARCHAR(255),
    W VARCHAR(255),
    E VARCHAR(255),
    R VARCHAR(100),
    PRIMARY KEY(id_ablilities)
);


CREATE TABLE CHAMPIONS(
	id_champion INT(2) NOT NULL,
    name_champion VARCHAR(255),
    basic_stats_id INT(2) NOT NULL,
    lore_id INT(2) NOT NULL,
    roles VARCHAR(255),
	ablilities_id INT(2) NOT NULL,
    price INT(4),
    numer_of_skin INT(2),
    PRIMARY KEY(id_champion),
    foreign key(basic_stats_id) references BASIC_STATS(id_stats),
    foreign key(lore_id) references LORE(id_lore),
    foreign key(ablilities_id) references ABLILITIES(id_ABLILITIES)
);
INSERT INTO ABLILITIES VALUES('1','Vastayan Grace','Orb of Deception','Fox-Fire','Charm','Spirit Rush');
INSERT INTO ABLILITIES VALUES('2','Unseen Predator','Savagery','Battle Roar','Bola Strike','Thrill of the Hunt');
INSERT INTO ABLILITIES VALUES('3','Surging Tides','Aqua Prison','Ebb and Flow','Tidecaller Blessing','Tidal Wave');
INSERT INTO ABLILITIES VALUES('4','Get Excited!','Switcheroo!','Zap!','Flame Chompers!','Super Mega Death Rocket!');
INSERT INTO ABLILITIES VALUES('5','Perseverance','Decisive Strike','Courage','Judgment','Demacian Justice');

INSERT INTO LORE VALUES('1','Ionia','Orb of Deception','F','Humanoid Fox');
INSERT INTO LORE VALUES('2','Ixtal',' Kirai Sabern','M','Kiilash');
INSERT INTO LORE VALUES('3','Mount Targon',' Tidecaller Staff','F','Trident');
INSERT INTO LORE VALUES('4','Zaun',' Fishbones','F','Human');
INSERT INTO LORE VALUES('5','Demacia','Sunsteel Broadsword','M','Human');

INSERT INTO BASIC_STATS VALUES('1','526','20','30','330','418');
INSERT INTO BASIC_STATS VALUES('2','585','34','32','345',NULL);
INSERT INTO BASIC_STATS VALUES('3','489','29','30','335','377');
INSERT INTO BASIC_STATS VALUES('4','581','28','30','325','245');
INSERT INTO BASIC_STATS VALUES('5','620','36','32','340',NULL);

INSERT INTO MODES VALUES('1','Normal','high','True','1');
INSERT INTO MODES VALUES('2','Rank','high','true','1');
INSERT INTO MODES VALUES('3','ARAM','medium','true','2');
INSERT INTO MODES VALUES('4','URF','high','false','1');
INSERT INTO MODES VALUES('5','One For All','medium','false','1');
INSERT INTO MODES VALUES('6','3v3','low','false','3');

INSERT INTO MAP VALUES('1','Summoner rift','high');
INSERT INTO MAP VALUES('2','Howling Abyss','medium');
INSERT INTO MAP VALUES('3','Twisted Treeline','low');

INSERT INTO CHAMPIONS VALUES('1','Ahri','1','1','MID','1','4800','8');
INSERT INTO CHAMPIONS VALUES('2','Rengar','2','2','JUNGLE','2','4800','5');
INSERT INTO CHAMPIONS VALUES('3','Nami','3','3','SUPPORT','3','4800','10');
INSERT INTO CHAMPIONS VALUES('4','Jinx','4','4','ADC','4','4800','4');
INSERT INTO CHAMPIONS VALUES('5','Garen','5','5','TOP','5','450','12');
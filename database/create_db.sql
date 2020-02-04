create sequence alg_seq;

  CREATE TABLE "SPATIAL_DEMO" 
   (	"ID" NUMBER, 
	"LATTITUDE" NUMBER, 
	"LONGITUDE" NUMBER, 
	"SDO_LOCATION" "SDO_GEOMETRY", 
	"ADDRESS" VARCHAR2(1000 BYTE)
   ) ;

  CREATE OR REPLACE TRIGGER "SPATIAL_DEMO_BI" 
  BEFORE INSERT OR UPDATE
  ON spatial_demo
  FOR EACH ROW
BEGIN
  :new.id := nvl(:new.id,alg_seq.nextval);
  /* convert coordinates to spatial object */
  :new.sdo_location := sdo_geometry( sdo_gtype     => 2001 /* 2-dimensional point */
                                   , sdo_srid      => 8307 /* Longitude / Latitude (WGS 84) */
                                   , sdo_point     => sdo_point_type(:new.longitude, :new.lattitude, null)
                                   , sdo_elem_info => null
                                   , sdo_ordinates => null
                                   );
END;
/
ALTER TRIGGER "SPATIAL_DEMO_BI" ENABLE;

REM INSERTING into SPATIAL_DEMO
SET DEFINE OFF;
Insert into SPATIAL_DEMO (ID,LATTITUDE,LONGITUDE,ADDRESS) values (113357,32.753041,35.279688,'Zipporis');
Insert into SPATIAL_DEMO (ID,LATTITUDE,LONGITUDE,ADDRESS) values (113355,32.070567,34.769355,'Galileo Hotel, Tel Aviv');
Insert into SPATIAL_DEMO (ID,LATTITUDE,LONGITUDE,ADDRESS) values (113356,32.880966,35.575362,'Old Synagoge, Kapernaum');
Insert into SPATIAL_DEMO (ID,LATTITUDE,LONGITUDE,ADDRESS) values (113358,31.998345,34.869404,'Ben Gurion Airport');
Insert into SPATIAL_DEMO (ID,LATTITUDE,LONGITUDE,ADDRESS) values (113372,32.101314,34.861093,'Aharon Bart St 20, Petah Tikva, Israël');

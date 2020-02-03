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
ALTER TRIGGER "FIN"."SPATIAL_DEMO_BI" ENABLE;

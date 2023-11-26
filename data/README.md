# Datasets

The datasets within this directory originate from the 
[Natural Earth open datasets](https://www.naturalearthdata.com) (NE) mostly
Small scale data, 1:110m. 

As the NE data is encoded in WGS84 (EPSG:4326), which
makes some calculations and analysis more complex, each dataset also has
a variant file that is in EPSG:3857 (Web Mercator) projection in meters.

For example: `countries.gpkg` is in WGS84 and `countries.3857.gpkg`
in EPSG:3857.

The original Downloads were Shapefiles. These were converted to GeoPackage
and sometimes also GeoJSON.

NB "Antarctica" has been removed from the "countries" datasets as it gave
problems with reprojections...

import shapely
from shapely.geometry import Point, LineString, Polygon, MultiPoint, MultiLineString, MultiPolygon


#genera un punto en ciertas coordenadas
Point(0,0)
#definir puntos en variables
a = Point(0, 0)
b = Point(1, 0)
#calcular distancia
a.distance(b)
print(a.distance(b))
#genera multiples puntos en un solo objeto
MultiPoint([(0,0), (0,1), (1,1), (1,0)])
#secuencia de puntos unidos por una linea
line = LineString([(0,0),(1,2), (0,1)])
line

#muestra los valores de la distancia y la localizacion de vertices
print(f'Length of line {line.length}')
print(f'Bounds of line {line.bounds}')

#genera un poligono
pol = Polygon([(0,0), (0,1), (1,1), (1,0)])
pol
#calcula el area del poligono previamente definido
print(pol.area)
#checa si hay interseccion entre objetos
pol.intersects(line)
#calcula la interseccion
pol.intersection(line)
#checa el tipo de objetos 
print(pol.intersection(line))

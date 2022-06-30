import matplotlib
import geopandas as gpd

world_gdf = gpd.read_file(
    gpd.datasets.get_path('naturalearth_lowres')
)
world_gdf

world_gdf.crs

world_gdf = world_gdf.to_crs("+proj=eck4 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs")
world_gdf.crs


world_gdf['pop_density'] = world_gdf.pop_est / world_gdf.area * 10**6

world_gdf.sort_values(by='pop_density', ascending=False)

figsize = (20, 11)

world_gdf.plot('pop_density', legend=True, figsize=figsize);

#The above map doesn't look very helpful, so let's make it better by doing the following:

#Change to the Mercator projection since it's more familiar.
#  Using the parameter to_crs('epsg:4326') can do that.
#Convert the colorbar to a logscale, which can be achieved using matplotlib.colors.
# LogNorm(vmin=world.pop_density.min(), vmax=world.pop_density.max())

norm = matplotlib.colors.LogNorm(vmin=world_gdf.pop_density.min(), vmax=world_gdf.pop_density.max())

world_gdf.to_crs('epsg:4326').plot("pop_density", 
                                   figsize=figsize, 
                                   legend=True,  
                                   norm=norm);
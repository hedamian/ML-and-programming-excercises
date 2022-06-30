import contextily as ctx

deaths_df = gpd.read_file('SnowGIS/Cholera_Deaths.shp')
pumps_df = gpd.read_file('SnowGIS/Pumps.shp')

deaths_df.head()

deaths_df.crs

pumps_df

pumps_df.crs

ax = deaths_df.plot(column='Count', alpha=0.5, edgecolor='k', legend=True)

ax = deaths_df.plot(column='Count', figsize=(15, 15), alpha=0.5, edgecolor='k', legend=True)
pumps_df.plot(ax=ax, marker='x', color='red', markersize=50)


ax = deaths_df.plot(column='Count', figsize=(15, 15), alpha=0.5, edgecolor='k', legend=True)
pumps_df.plot(ax=ax, marker='x', color='red', markersize=50)

ctx.add_basemap(
    ax,
    # CRS definition. Without the line below, the map stops making sense
    crs=deaths_df.crs.to_string(),
)


ax = deaths_df.plot(column='Count', figsize=(15, 15), alpha=0.5, edgecolor='k', legend=True)
pumps_df.plot(ax=ax, marker='x', color='red', markersize=50);

ctx.add_basemap(ax,
    crs=deaths_df.crs.to_string(),
    # Using the original map, hand-drawn by Snow
    source="SnowGIS/SnowMap.tif"
)
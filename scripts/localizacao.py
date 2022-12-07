import geolocate
import pandas

end = dataset['endereco_completo'].astype(str).str.strip()
end_geo = geolocate_batch(end)
dataset['lat'] = [lat['latitude'] for lat in end_geo]
dataset['long'] = [lat['longitude'] for lat in end_geo]

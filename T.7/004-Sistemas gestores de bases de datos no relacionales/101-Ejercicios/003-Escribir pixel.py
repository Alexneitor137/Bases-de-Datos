drom PIL import Image

img = Image.open("img.jpg")
pixels = imh.load() #Acceso directo a pixeles

# Leer el color del pixel (0,0)
pixel_color = pixels[0,0]
print(pixel_color)

# Modificar el pixel (0,0) en la imagen original
pixels[0,0] = (255,0,0) # Cambia el pixel a rojo

# Guardar la imagen modificada
img.save("img_mod.jpg")
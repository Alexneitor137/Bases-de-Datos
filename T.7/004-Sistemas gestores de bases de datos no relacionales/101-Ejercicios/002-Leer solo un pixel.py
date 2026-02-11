drom PIL import Image

img = Image.open("img.jpg")
pixels = imh.load() #Acceso directo a pixeles

pixel = pixels[0,0,]
print(pixel)
drom PIL import Image

img = Image.open("img.jpg")
pixels = imh.load() #Acceso directo a pixeles

width, height = img.size

for y in range(height):
    for x in range(width):
        pixel = pixels(x,y,pixel)
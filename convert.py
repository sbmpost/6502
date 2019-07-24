from PIL import Image

image = Image.open("birds.png")

a = 1
b = 0
c = 1
d = 0
e = 1
f = 1

shifted = image.transform(image.size, Image.AFFINE, (a, b, c, d, e, f))
shifted.save("birds_shifted.png")

pixels = shifted.load()

for y in range(200):
  for x in range(40):
    rgb1 = pixels[(8*x)+0,y]
    rgb2 = pixels[(8*x)+1,y]
    rgb3 = pixels[(8*x)+2,y]
    rgb4 = pixels[(8*x)+3,y]
    rgb5 = pixels[(8*x)+4,y]
    rgb6 = pixels[(8*x)+5,y]
    rgb7 = pixels[(8*x)+6,y]
    rgb8 = pixels[(8*x)+7,y]

    bit1 = (rgb1[0] > 128 and rgb1[1] > 128 and rgb1[2] > 128) or (x == 39 or y == 199)
    bit2 = (rgb2[0] > 128 and rgb2[1] > 128 and rgb2[2] > 128) or (x == 39 or y == 199)
    bit3 = (rgb3[0] > 128 and rgb3[1] > 128 and rgb3[2] > 128) or (x == 39 or y == 199)
    bit4 = (rgb4[0] > 128 and rgb4[1] > 128 and rgb4[2] > 128) or (x == 39 or y == 199)
    bit5 = (rgb5[0] > 128 and rgb5[1] > 128 and rgb5[2] > 128) or (x == 39 or y == 199)
    bit6 = (rgb6[0] > 128 and rgb6[1] > 128 and rgb6[2] > 128) or (x == 39 or y == 199)
    bit7 = (rgb7[0] > 128 and rgb7[1] > 128 and rgb7[2] > 128) or (x == 39 or y == 199)
    bit8 = (rgb8[0] > 128 and rgb8[1] > 128 and rgb8[2] > 128) or (x == 39 or y == 199)
    print("memory[%d]=8'b%d%d%d%d%d%d%d%d;" % (8000+y*40+x, bit1, bit2, bit3, bit4, bit5, bit6, bit7, bit8))

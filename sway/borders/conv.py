import png, math
from typing_extensions import TypeAlias
from typing import Tuple, List

ALPHA = 255 // 2
SHADOW = 0.75
RADIUS = 4
FALLOFF = 12
OFFSET = (1, 1)
COLORS = {
    "blue": "#51afef",
    "green": "#98be65",
    "red": "#ff6c6b",
    "yellow": "#f2c68a",
    "purple": "#c678dd",
    "grey": "#a0a0a0",
}

Color: TypeAlias = Tuple[int, int, int, int]

def hex_to_rgba(color: str, alpha) -> Color:
    r = int(color[1:3], 16)
    g = int(color[3:5], 16)
    b = int(color[5:7], 16)
    return (r, g, b, alpha)

def get_data(color: Color) -> List[List[Color]]:
    null: Color = (0, 0, 0, 0)
    dist = max(RADIUS, FALLOFF) + max(OFFSET[0], OFFSET[1])
    dimension = dist + 1
    output: List[List[Color]] = []
    for y in range(-dimension + 1, dimension):
        row = []

        if y == 0:
            last = output[-1]
            for x in range(dimension * 2 - 1):
                pixel = last[4 * x : 4 * (x+1)]
                if abs(x - dimension + 1) <= RADIUS:
                    pixel = color
                for c in pixel:
                    row.append(c)
            output.append(row)
            continue

        for x in range(-dimension + 1, dimension):
            h = math.hypot(x, y)
            j = math.hypot(x - OFFSET[0], y - OFFSET[1])
            pixel = null
            if h <= RADIUS:
                pixel = color
            elif j < dist:
                o = max((FALLOFF - (j)) / FALLOFF, 0)
                pixel = (0, 0, 0, math.floor(o * SHADOW * ALPHA))
            for c in pixel:
                row.append(c)

        output.append(row)
    return output

def save_colors():
    for name, color in COLORS.items():
        data = get_data(hex_to_rgba(color, ALPHA))
        image = png.from_array(list(data), "RGBA")
        image.save(name + ".png")

if __name__ == "__main__":
    save_colors()

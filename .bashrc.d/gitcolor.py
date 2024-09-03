from color import colored
import sys

def git_color(text:str):
    rtxt = ""
    for i in text:
        match i:
            case "+": # staged
                rtxt += colored(i, "Green")
            case "*":
                rtxt += colored(i, "Yellow")
            case "%":
                rtxt += colored(i, "Red")
            case "$":
                rtxt += colored(i, "Purple")
            case "<":
                rtxt += colored(i, "Yellow")
            case ">":
                rtxt += colored(i, "Yellow")
            case "=":
                rtxt += colored(i, "Cyan")
            case _:
                rtxt += i
    return rtxt

if __name__ == "__main__":
    if len(sys.argv) == 2:
        print(git_color(sys.argv[1]))
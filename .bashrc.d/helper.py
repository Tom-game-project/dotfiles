import sys


GREEN = "\033[32m"
RED = "\033[31m"
# end
END = "\033[0m"

def say_hello(arg):
    print(f"hello world{arg}")


if __name__ == "__main__":
    print(sys.argv)
    if 1 < len(sys.argv):
        say_hello(sys.argv[1])
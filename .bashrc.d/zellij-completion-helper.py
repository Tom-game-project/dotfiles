import argparse
import logging
import os


logging.basicConfig(
        filename=os.path.expanduser("~/.bashrc.d/zellij_completion.log"),
        format="%(filename)s : %(message)s",
        level=logging.DEBUG
        )
logging.disable(logging.DEBUG)


def zellij_compl(
        cur: str,
        prev: str,
        cword: str,
        *candidate: list[str]
        ) -> str:
    """
    # func
    """
    candidate_list = candidate[0]
    rlist = []
    logging.debug("%s %s" % (prev, candidate_list))
    logging.debug("%s %s" % (prev,
prev in [
        "a",
        "attach"
        "k",
        "kill-session",
        "d",
        "delete-session"
    ]
                             ))
    logging.debug("%s %s" % (prev,
                             any( map(lambda a : prev ==a ,[
        "a",
        "attach"
        "k",
        "kill-session",
        "d",
        "delete-session"
    ]))
                             ))
    if prev in [
        "a",
        "attach"
        "k",
        "kill-session",
        "d",
        "delete-session"
    ]:
        for i in candidate_list:
            if i.startswith(cur):
                rlist.append(i)
    if len(rlist) != 1:
        rlist = []
    return ' '.join(rlist)


def main():
    parser = argparse.ArgumentParser(description="Process some integers.")
    # 名前付き引数を追加
    parser.add_argument('--cur', nargs="?", type=str, help='a string argument')
    parser.add_argument('--prev', type=str, help='a string argument')
    parser.add_argument('--cword', type=int, help='a integer argument')
    parser.add_argument(
            '--candidate',
            type=str,
            nargs="+",
            help='a integer argument'
            )

    args = parser.parse_args()
    print(zellij_compl(
        "" if args.cur is None else args.cur,
        args.prev,
        args.cword,
        args.candidate,
    ))


if __name__ == "__main__":
    main()

#! /usr/bin/env python3
import sys
import pydocstring


def generate_docstring(source, position, formatter="google"):
    """Docstring gen func.
    Availible formatter types:
      'google'
      'numpy'
      'reST'
    """
    docstring = pydocstring.generate_docstring(source, position, formatter)
    if docstring:
        return f'"""{docstring}"""'
    else:
        return "No docstring generated"


if __name__ == "__main__":
    source = sys.argv[1]
    # print(f"raw source str: {source}")

    source = f" \n{(source or '').lstrip()}\n    pass"
    # print(f"formatted source: {source}")

    # hardcore it!
    position = (2, 2)

    formatter = sys.argv[2]
    # print(f"formatter: {formatter}")

    docstring = generate_docstring(source, position, formatter)
    print(docstring)

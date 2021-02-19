### TODO - February 12, 2021:
==========================================================================
- SSH Keys
- Script
- Encrypted files (hashing algorithm)
- Setup `rsync`

### OVERALL GOAL
==========================================================================

**read pdf -> sort data -> SQL -> print to website -> print to IRS**

**folder input -> script -> move folder -> filename SQL**
  - file in folder = processing

```
| Todo                          | Done?        |
| :===========================  | :=========== |
| File input to website         |              |
| File in folder recognition    |              |
| Script to run clearing folder | yes          |
| Reading PDF                   | for coinbase |
| Sorting PDF / to SQL          |              |
| Print back to website         |              |
| Print to RSS? maybe IRS       |              |
|                               |              |
```

```sh
# pdftotext
sudo apt install poppler-utils
```
==========================================================================


### BACKEND
==========================================================================
```sh
# pdftotext
pdftotext -layout cb_input.pdf output.txt
pdftotext -layout -nopgbrk -eol unix cb_input.pdf
```

```sh
# file exists
[[ -f *.pdf ]] && echo "File in folder"
```


### FRONTEND
==========================================================================

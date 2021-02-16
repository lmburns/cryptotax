# Commands
#### Long one row
`tr ' ' '\n' < cb_cleanest.txt| pr -$(wc -l < cb_cleanest.txt)t | column -t`

```sh
FILE='pdftotext -layout -nopgbrk -eol unix $PDF'
gsed -i 's/  \+/\t/g' $FILE
cat cptab.txt | cut -f1,2
```

```sh
awk -v ORS='\n\n' '/^[0-9]{4}-[0-9]{2,4}-?[0-9]{2}?T[0-9]{2}:[0-9]{2}:[0-9]{2}Z/' cb_plain.txt

pdftotext -nopgbrk -layout cb_input.pdf - | sd $(cat replace) '' | awk 'NR>31{print $0;}' | column -t

awk -F' ' '{print $0}' cb_layout.txt | awk 'NR>31{print $0}' | tr -s ' ' | awk 'BEGIN{RS="";ORS="\n\n"}1' | awk -F'.' 'NF!=2' | tr -d '^\s*$'| bat
```

```sh
awk 'NR%2{printf "%s ",$0;next;}1' cb_input.txt > cb_cleanest.txt
awk -F' ' '{print $0}' | sd $(cat replace) '' | column -t | awk 'NR>10{print $0}' | awk 'NF{NF-=1};1'
awk '{for(i=2; i<NF-1; ++i) $i=$(i+2); NF-=2; print $0}'
sd $(cat replace) '' | sed '/^$/N;/^\n$/D' | awk 'NR>12{print}' | sed 'N;s/\n/\t/' | column -t
sd $(cat replace) '' | rg --color=never . | awk 'NR>8{print}' | column
```

## New
## Best so far
```sh
sd $(cat replace) '' | sed 's/[ ]*//g' | sed '/^$/d'
```


``$(generate list of files) | while read f; do rg pattern "$f"; done`
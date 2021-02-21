## Helper Commands

```sh
# Enter a column for doc_id
awk 'BEGIN{OFS=" "; col1=69}{print col1,$0; col1+=0}'

# Enter column for amount_left
awk -v OFS=" " '{$10 = int(rand()*1000)} {print}'

# Add email to beginning of every line
awk '$1="burnsac@me.com "$1

# Read column; add from file 'f3'; save to_add
awk 'BEGIN{getline to_add < "f3"}{print $0,to_add}' f
```

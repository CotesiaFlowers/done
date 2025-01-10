_U_ ← {⍺←{⍵ ⋄ ⍺⍺} ⋄ ⍵⍵⍣¯1⊢(⍵⍵ ⍺)⍺⍺(⍵⍵ ⍵)}

Q ← ⎕CSV 'QueryData-25-11-24(12_36_37).csv' ⍝ Purchase Order Items | 01/11/01 - 25/11/24
hdr ← 1↑Q
Q ← 1↓Q
L ← {(,⍵)⍳⊆⍺}
skus   ← Q[;'ItemNumber'    L hdr]
pds    ← Q[;'Purchase Date' L hdr]
titles ← Q[;'ItemTitle'     L hdr]

d2pn ← {100⊥100|⌽⍎¨'/'(≠⊆⊢)10↑⍵} ⍝ Date to padded number

R ← skus {⊂⍺,(10∘↑_U_⊃⍵[⊃⍒d2pn¨⍵])}⌸ pds ⍝ SKU | most recent purchase date

R2 ← R {(⍺,⊂⍵)[1 3 2]}¨ skus {1⌷⍵}⌸ titles

(↓⍉↑R2) (⎕CSV⍠2) 'sheet.csv'

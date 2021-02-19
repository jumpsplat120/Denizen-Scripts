# returns the value of a mathmatical expression.
# | Each element must be SPACE separated. NOT very performant
expression:
    type: procedure
    definitions: equation
    debug: false
    script:
        - define list "<[equation].split[ ]>"
        - define start_index 0
        - define end_index 0
        - define none false
        - define index 1
        #find and solve in parathenses
        - while <[index].is[OR_LESS].than[<[list].size>]>:
            - if <[index]> > <[list].size>:
                    - while stop
            - define value <[list].get[<[index]>]>
            - if <[value].is[==].to[(]>:
                - define start_index <[index]>
            - if <[value].is[==].to[)]>:
                - define end_index <[index]>
            - if <[start_index]> > 0 && <[end_index]> > 0:
                - define list <[list].get[<tern[<[start_index].sub[1].is[LESS].than[1]>].pass[2].fail[1]>].to[<tern[<[start_index].sub[1].is[LESS].than[1]>].pass[1].fail[<[start_index].sub[1]>]>].include[<proc[expression].context[<[list].get[<[start_index].add[1]>].to[<[end_index].sub[1]>].space_separated>]>].include[<tern[<[end_index].add[1].is[MORE].than[<[list].size>]>].pass[].fail[<[list].get[<[end_index].add[1]>].to[last]>]>]>
                - define start_index 0
                - define end_index 0
                - define index 0
            - define index <[index].add[1]>
            - if <[loop_index]> > 30:
                - while stop
        #exponents
        - while <[list].size.is[MORE].than[1]>:
            - if <[index]> >= <[list].size>:
                    - while stop
            - if <[list].get[<[index]>].is_decimal>:
                - define i1 <[index]>
                - define i2 <[index].add[1]>
                - define i3 <[index].add[2]>
                - if <[list].get[<[i2]>]> == '^':
                    - define list <[list].remove[<[i1]>|<[i2]>|<[i3]>].insert[<[list].get[<[i1]>].pow[<[list].get[<[i3]>]>]>].at[<[i1]>]>
                    - define index 0
            - define index <[index].add[1]>
        - define index 1
        #multiplication/division
        - while <[list].size.is[MORE].than[1]>:
            - if <[index]> >= <[list].size>:
                    - while stop
            - if <[list].get[<[index]>].is_decimal>:
                - define i1 <[index]>
                - define i2 <[index].add[1]>
                - define i3 <[index].add[2]>
                - define n1 <[list].get[<[i1]>]>
                - define n2 <[list].get[<[i3]>]>
                - if <[list].get[<[i2]>]> == '*':
                    - define list <[list].remove[<[i1]>|<[i2]>|<[i3]>].insert[<[n1].mul[<[n2]>]>].at[<[i1]>]>
                    - define index 0
                - else if <[list].get[<[i2]>]> == '/':
                    - define list <[list].remove[<[i1]>|<[i2]>|<[i3]>].insert[<[n1].div[<[n2]>]>].at[<[i1]>]>
                    - define index 0
            - define index <[index].add[1]>
        #addition/subtraction
        - define index 1
        - while <[list].size.is[MORE].than[1]>:
            - if <[index]> >= <[list].size>:
                    - while stop
            - if <[list].get[<[index]>].is_decimal>:
                - define i1 <[index]>
                - define i2 <[index].add[1]>
                - define i3 <[index].add[2]>
                - define n1 <[list].get[<[i1]>]>
                - define n2 <[list].get[<[i3]>]>
                - if <[list].get[<[i2]>]> == '+':
                    - define list <[list].remove[<[i1]>|<[i2]>|<[i3]>].insert[<[n1].add[<[n2]>]>].at[<[i1]>]>
                    - define index 0
                - else if <[list].get[<[i2]>]> == '-':
                    - define list <[list].remove[<[i1]>|<[i2]>|<[i3]>].insert[<[n1].sub[<[n2]>]>].at[<[i1]>]>
                    - define index 0
            - define index <[index].add[1]>
        - determine <[list].first>
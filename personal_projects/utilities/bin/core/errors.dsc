error_type_check:
    type: procedure
    debug: false
    definitions: name|types|object|queue
    script:
        - define types  <[types].split[,]> if:<[types].object_type.equals[element]>
        - define actual <[object].object_type>
        - if <[actual].to_lowercase> not in <[types]>:
            - define formatted <&sq><[types].first><&sq>
            - foreach <[types].get[2].to[-2]> if:<[types].size.is_more_than[2]>:
                - define formatted "<[formatted]>, '<[value]>'"
            - define formatted "<[formatted]> or '<[types].last>'" if:<[types].size.is_more_than[1]>
            - debug error "<[queue].script.name.to_uppercase>: Argument '<[name]>' is supposed to be of <[formatted]>, but was instead of type '<[actual]>'."
            - determine true
        - determine false

error_missing_check:
    type: procedure
    debug: false
    definitions: name|null|object|queue
    script:
        - if <[object]> == <[null]>:
            - debug error "<[queue].script.name.to_uppercase>: Missing argument '<[name]>'."
            - determine true
        - determine false

error_number_check:
    type: procedure
    debug: false
    definitions: name|object|queue
    script:
        - if not <[object].is_decimal>:
            - debug error "<[queue].script.name.to_uppercase>: Argument '<[name]>' is not a numeric value."
            - determine true
        - determine false

error_boolean_check:
    type: procedure
    debug: false
    definitions: name|object|queue
    script:
        - if not <[object].is_boolean>:
            - debug error "<[queue].script.name.to_uppercase>: Argument '<[name]>' is not a boolean value."
            - determine true
        - determine false
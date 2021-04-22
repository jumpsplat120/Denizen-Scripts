co_error_command:
    type: custom
    debug: false
    inherit: co_error
    tags:
        type:
            - determine Error.Command
        errors:
            - determine <script[generic_lib_data].data_key[command.error]>
        permission:
            - define list <custom_object[co_lib_core].parse_list[<context.value>]>
            - if <player||nil> != nil:
                - if !<custom_object[co_lib].has.permission[<player>|<[list].get[1]>]>:
                    - determine <context.this.color><context.this.errors.get[permission].parsed>
            - determine true
        wrong_args:
            - define list <custom_object[co_lib_core].parse_list[<context.value>]>
            - if <context.this._explicit_size> != <context.this._arg_amount>:
                - define arg_amount <context.this._arg_amount>
                - define usage      <context.this._usage>
                - define size       <context.this._explicit_size>
                - determine <context.this.color><context.this.errors.get[wrong_args].parsed>
            - determine true
        min_args:
            - define list <custom_object[co_lib_core].parse_list[<context.value>]>
            - if <context.this._explicit_size> < <context.this._min_args>:
                - define min_args <context.this._min_args>
                - define usage    <context.this._usage>
                - define size     <context.this._explicit_size>
                - determine <context.this.errors.get[min_args].parsed>
            - determine true
        max_args:
            - define list <custom_object[co_lib_core].parse_list[<context.value>]>
            - if <context.this._explicit_size> > <context.this._max_args>:
                - define max_args <context.this._max_args>
                - define usage    <context.this._usage>
                - define size     <context.this._explicit_size>
                - determine <context.this.color><context.this.errors.get[max_args].parsed>
            - determine true
        missing_req:
            - define list <custom_object[co_lib_core].parse_list[<context.value>]>
            - if <[list].get[1]>:
                - define required <[list].get[2]>
                - define usage    <context.this._usage>
                - define value    <[list].get[3]>
                - determine <context.this.color><context.this.errors.get[missing_req].parsed>
            - determine true
    mechanisms:
        _set:
            - define core <custom_object[co_lib_core]>
            - define list <[core].parse_list[<context.value>]>
            - if <[list].get[1]> == usage:
                - adjust <context.this> _usage:<[core].command_usage[<[list].get[2]>]> save:value
            - else:
                - adjust <context.this> _<[list].get[1]>:<[list].get[2]> save:value
            - determine <entry[value].result>

co_error:
    type: custom
    debug: false
    inherit: co_base
    tags:
        type:
            - determine Error
        as_boolean:
            - determine false
        command:
            - determine <custom_object[co_error_command]>
        color:
            - determine <script[lib_config].data_key[color.error].parsed>
        errors:
            - determine <script[generic_lib_data].data_key[error_messages]>
        set:
            - foreach <context.value>:
                - adjust <entry[val].result||<context.this>> _set:<[key]>|<[value]> save:val
            - determine <entry[val].result>
        wrong_type:
            - define list <custom_object[co_lib_core].parse_list[<context.value>]>
            - if <[list].get[1].type> != <[list].get[2]>:
                - define bad_type <[list].get[1].type>
                - define title    <context.this._title>
                - define type     <[list].get[2]>
                - debug error <context.this.color><context.this.errors.get[wrong_type].parsed>
                - determine true
            - determine false
        wrong_args:
            - if <context.this._explicit_size> != <context.this._arg_amount>:
                - define arg_amount <context.this._arg_amount>
                - define title      <context.this._title>
                - define size       <context.this._explicit_size>
                - debug error <context.this.color><context.this.errors.get[wrong_args].parsed>
                - determine true
            - determine false
        min_args:
            - if <context.this._explicit_size> < <context.this._min_args>:
                - define min_args <context.this._min_args>
                - define title    <context.this._title>
                - define size     <context.this._explicit_size>
                - debug error <context.this.color><context.this.errors.get[min_args].parsed>
                - determine true
            - determine false
        max_args:
            - if <context.this._explicit_size> > <context.this._max_args>:
                - define max_args <context.this._max_args>
                - define title    <context.this._title>
                - define size     <context.this._explicit_size>
                - debug error <context.this.color><context.this.errors.get[max_args].parsed>
                - determine true
            - determine false
        empty:
            - if <context.value.is_nil||false>:
                - define title <context.this._title>
                - debug error <context.this.color><context.this.errors.get[empty].parsed>
                - determine true
            - determine false
        invalid_range:
            - define list <custom_object[co_lib_core].parse_list[<context.value>]>
            - if <[list].get[1]> > <[list].get[2]>:
                - define min <[list].get[1]>
                - define max <[list].get[2]>
                - debug error <context.this.color><context.this.errors.get[invalid_range].parsed>
                - determine true
            - determine false
        not_number:
            - if <context.value.is_decimal.not||true>:
                - define number <context.value>
                - debug error <context.this.color><context.this.errors.get[not_number].parsed>
                - determine true
            - determine false
    mechanisms:
        _set:
            - define list <custom_object[co_lib_core].parse_list[<context.value>]>
            - adjust <context.this> _<[list].get[1]>:<[list].get[2]> save:value
            - determine <entry[value].result>
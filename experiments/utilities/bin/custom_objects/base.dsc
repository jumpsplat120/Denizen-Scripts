# | Nearly everything here is some pretty dramatic object hacking.
# | In no way should this be replicated or used as an example of good scripting practices.

#- Differences between normal custom objects and co_* custom objects:
#-     * They generally all contain their own type. This both makes it easier for
#-          debugging purposes when an object returns a type as "Is" or "Error"
#-          and not always as "Custom".
#-     * Most co_* custom objects will return true when converted to boolean. This
#-          is dissimilar to how Elements work in Denizen, where everything is
#-          considered false, and only true is considered true. However, some values
#-          do parse as false, such as Error and Nil. Basically, if it is a "thing",
#-          it'll parse as true, and if it's a "broken/not thing" then it'll parse
#-          as false.
#-     * Errors are thrown when manipulating custom objects with empty properties;
#-          the parsing engine thinks you are trying to set a blank string as a
#-          property. Simply setting any property at all prevents this from happening.

co_base:
    type: custom
    debug: false
    prop_fix: true
    tags:
        type:
            - determine Object
        is_nil:
            - determine false
        is_boolean:
            - determine false
        is_integer:
            - determine false
        is_decimal:
            - determine false
        is_odd:
            - determine false
        is_even:
            - determine false
        as_boolean:
            - determine true
        as_element:
            - determine el@<context.this>
        as_custom:
            - determine <context.this>
        as_list:
            - determine <list[<context.this>]>
        scriptname:
            - determine <context.this.after[custom@].before[<&lb>].to_lowercase>
        property_map:
            - determine <context.this.after[<&lb>].before[<&rb>].split[;].to_map[=]>
        inherits:
            - determine <script[<context.this.scriptname>].data_key[inherit]||<custom_object[co_nil]>>
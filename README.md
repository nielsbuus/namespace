# namespace

JavaScript has no native support for anything resembling namespacing or packaging. To avoid cluttering up the global object with everything, but the kitchen sink, developers tend to create (often nested) application objects and attach them to the global object, `window`.

However, these can be sort of brittle, because you have to define parent nodes prior to leaf nodes, which can break your code if you don't have the right load order.

    myapp.domain.prototypes.User = /* a constructor function for User objects */

will break unless `myapp`, `domain` and `prototypes` have all been sequentially declared prior to loading and defining `User`.

This sucks and leads uncertain developers to write code that checks if parent branches are defined before defining the leaf node which is what matters.

This library solves that nuisance.

    parent = namespace('myapp.domain.prototypes');
    parent.User = /* a constructor function for User objects */
    some_user = new myapp.domain.prototypes.User("Niels");

The cool thing here is that parent nodes do not need to be defined. If any nodes in the path are missing, they will be defined with an empty object and then augmented with the next node in the path. If any node in the namespace path is not an object, an error will be thrown.

    window.myapp.the_game = "you just lost it"
    utils = namespace('myapp.the_game.utils')

    => "Namespace error! Augmentation not allowed for non-objects. 'myapp.the_game'
       is a type of string. Namespace 'my_app.the_game.utils' could not be defined."

By default `namespace` will augment the `window object`, but if you want to augment something else, you can pass it in as the second argument.

    namespace('some.new.stuff', my_object)
    my_object.some.new.stuff
    => {}

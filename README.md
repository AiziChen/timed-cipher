# timed-password

a time based cipher


## The mode of operation

there are two sides you should to know.

### generation side

1. specify a `duration`.

2. password generated base on this `duration`.

### verify side

1. define a `duration` on generation-side.

2. password generated base on this `duration`,
and on previous `duration`, and on next `duration`.

3. if the generation-side want to verify it's password,
these 3 passwords are all verifiable of generating by the verify-side.



## What can you use?

1. Used in the field of time delay.

such as: network verify.

2. Ensure that your password is not fixed.


## Others

* Use this simple cipher to create your own cipher.

* See `examples` folder to see details.


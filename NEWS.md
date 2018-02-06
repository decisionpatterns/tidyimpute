## Version 

 - Add `NA_explicit_` as an exported constant for explicit categorical values.
 - Convert man to use markdown.
 

## Version 0.7.3 (2018-01-22) 
 
 - Fix `na_replace` (and `na_explicit`) to add levels for values if
   they do not already exist.
 - Add tests
 - Fix documentation

## Version 0.7.0 (2017-08-22)

 - Add na_explicit and na_implicit

## Version 0.6.2

 - na_replace: revert from using `ifelse` because of edge cases 
 - add `zzz.R`
 - add `NEWS.md`
 - add tests for `na_replace`

## Version 0.6.1

 - `na_replace` now uses `ifelse` and prevent recycling `value`

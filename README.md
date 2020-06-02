# SwiftYMD

[![Build Status](https://travis-ci.org/koher/swift-ymd.svg?branch=master)](https://travis-ci.org/koher/swift-ymd)

_SwiftYMD_ helps to calculate dates in the forms of `YMD` and `YM`.

```swift
let ymd1 = YMD(1988, 12, 3)!   // Dec. 3, 1988
let ymd2 = ymd1 + .days(11331) // Dec. 12, 2012
print(ymd2 - ymd1)             // 11331
print(ymd2.dayOfWeek)          // Thursday

for ymd in YMD(1988, 12, 3)! ... YMD(2019, 12, 12)! {
    // ...
}
```

## License

[MIT](LICENSE)

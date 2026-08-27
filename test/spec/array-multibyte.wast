;; Current Syntax: (type $i8_array)
;;
;; (func $test2 (export "test2")
;;   (i32.store (type $typeIdx)
;;     (global.get $arr_4)
;;     (i32.const 1)
;;     (i32.const 1337)
;;   )
;; )

;; Alternative Syntax 1: type=array
;;
;; (func $test2 (export "test2")
;;   (i32.store type=array
;;     (global.get $arr_4)
;;     (i32.const 1)
;;     (i32.const 1337)
;;   )
;; )

;; Alternative Syntax 2: array
;;
;; (func $test2 (export "test2")
;;   (i32.store array
;;     (global.get $arr_4)
;;     (i32.const 1)
;;     (i32.const 1337)
;;   )
;; )

;; Alternative Syntax 3: new opcodes
;;
;; (func $test2 (export "test2")
;;   (i32.array.store
;;     (global.get $arr_4)
;;     (i32.const 1)
;;     (i32.const 1337)
;;   )
;; )

(module
  (type $i8_array (array (mut i8)))

  (global $arr_4 (ref $i8_array)
    (array.new_default $i8_array (i32.const 4))
  )

  (global $arr_8 (ref $i8_array)
    (array.new_default $i8_array (i32.const 8))
  )

  (func $get_array_4_byte (export "get_array_4_byte") (param $idx i32) (result i32)
    (array.get_u $i8_array (global.get $arr_4) (local.get $idx))
  )

  (func $get_array_8_byte (export "get_array_8_byte") (param $idx i32) (result i32)
    (array.get_u $i8_array (global.get $arr_8) (local.get $idx))
  )

  (func $i32_set_i8 (export "i32_set_i8") (param $index i32) (param $value i32)
    (i32.store8 (type $i8_array)
      (global.get $arr_4)
      (local.get $index)
      (local.get $value)
    )
  )

  (func $i32_set_i16 (export "i32_set_i16") (param $index i32) (param $value i32)
    (i32.store16 (type $i8_array)
      (global.get $arr_4)
      (local.get $index)
      (local.get $value)
    )
  )

  (func $i32_set_i32 (export "i32_set_i32") (param $index i32) (param $value i32)
    (i32.store (type $i8_array)
      (global.get $arr_4)
      (local.get $index)
      (local.get $value)
    )
  )

  (func $f32_set (export "f32_set") (param $index i32) (param $value f32)
    (f32.store (type $i8_array)
      (global.get $arr_4)
      (local.get $index)
      (local.get $value)
    )
  )

  (func $i64_set_i8 (export "i64_set_i8") (param $index i32) (param $value i64)
    (i64.store8 (type $i8_array)
      (global.get $arr_8)
      (local.get $index)
      (local.get $value)
    )
  )

  (func $i64_set_i16 (export "i64_set_i16") (param $index i32) (param $value i64)
    (i64.store16 (type $i8_array)
      (global.get $arr_8)
      (local.get $index)
      (local.get $value)
    )
  )

  (func $i64_set_i32 (export "i64_set_i32") (param $index i32) (param $value i64)
    (i64.store32 (type $i8_array)
      (global.get $arr_8)
      (local.get $index)
      (local.get $value)
    )
  )

  (func $i64_set_i64 (export "i64_set_i64") (param $index i32) (param $value i64)
    (i64.store (type $i8_array)
      (global.get $arr_8)
      (local.get $index)
      (local.get $value)
    )
  )

  (func $f64_set (export "f64_set") (param $index i32) (param $value f64)
    (f64.store (type $i8_array)
      (global.get $arr_8)
      (local.get $index)
      (local.get $value)
    )
  )

  ;; TODO: Do we even want to spec out this instruction since array.set is the
  ;; same thing? See
  ;; https://github.com/WebAssembly/multibyte-array-access/issues/2
  (func $i32_set_and_get_i8 (export "i32_set_and_get_i8") (param $value i32) (result i32)
    (i32.store8 (type $i8_array)
      (global.get $arr_4)
      (i32.const 0)
      (local.get $value)
    )
    (i32.load8_u (type $i8_array) (global.get $arr_4) (i32.const 0))
  )

  (func $i32_set_and_get_i16 (export "i32_set_and_get_i16") (param $value i32) (result i32)
    (i32.store16 (type $i8_array)
      (global.get $arr_4)
      (i32.const 0)
      (local.get $value)
    )
    (i32.load16_u (type $i8_array) (global.get $arr_4) (i32.const 0))
  )

  (func $i32_set_and_get_i32 (export "i32_set_and_get_i32") (param $value i32) (result i32)
    (i32.store (type $i8_array)
      (global.get $arr_4)
      (i32.const 0)
      (local.get $value)
    )
    (i32.load (type $i8_array) (global.get $arr_4) (i32.const 0))
  )

  (func $set_and_get_f32 (export "set_and_get_f32") (param $value f32) (result f32)
    (f32.store (type $i8_array)
      (global.get $arr_4)
      (i32.const 0)
      (local.get $value)
    )
    (i32.load (type $i8_array) (global.get $arr_4) (i32.const 0))
    (f32.reinterpret_i32)
  )

  (func $i64_set_and_get_i8 (export "i64_set_and_get_i8") (param $value i64) (result i64)
    (i64.store8 (type $i8_array)
      (global.get $arr_8)
      (i32.const 0)
      (local.get $value)
    )
    (i64.load8_u (type $i8_array) (global.get $arr_8) (i32.const 0))
  )

  (func $i64_set_and_get_i16 (export "i64_set_and_get_i16") (param $value i64) (result i64)
    (i64.store16 (type $i8_array)
      (global.get $arr_8)
      (i32.const 0)
      (local.get $value)
    )
    (i64.load16_u (type $i8_array) (global.get $arr_8) (i32.const 0))
  )

  (func $i64_set_and_get_i32 (export "i64_set_and_get_i32") (param $value i64) (result i64)
    (i64.store32 (type $i8_array)
      (global.get $arr_8)
      (i32.const 0)
      (local.get $value)
    )
    (i64.load32_u (type $i8_array) (global.get $arr_8) (i32.const 0))
  )

  (func $i64_set_and_get_i64 (export "i64_set_and_get_i64") (param $value i64) (result i64)
    (i64.store (type $i8_array)
      (global.get $arr_8)
      (i32.const 0)
      (local.get $value)
    )
    (i64.load (type $i8_array) (global.get $arr_8) (i32.const 0))
  )

  (func $set_and_get_f64 (export "set_and_get_f64") (param $value f64) (result f64)
    (f64.store (type $i8_array)
      (global.get $arr_8)
      (i32.const 0)
      (local.get $value)
    )
    (i64.load (type $i8_array) (global.get $arr_8) (i32.const 0))
    (f64.reinterpret_i64)
  )
  (func $load_i32_16_u (export "load_i32_16_u") (param $idx i32) (result i32)
    (i32.load16_u (type $i8_array) (global.get $arr_4) (local.get $idx))
  )

  (func $load_i32_16_s (export "load_i32_16_s") (param $idx i32) (result i32)
    (i32.load16_s (type $i8_array) (global.get $arr_4) (local.get $idx))
  )

  (func $load_i32 (export "load_i32") (param $idx i32) (result i32)
    (i32.load (type $i8_array) (global.get $arr_4) (local.get $idx))
  )
  (func $load_i64 (export "load_i64") (param $idx i32) (result i64)
    (i64.load (type $i8_array) (global.get $arr_8) (local.get $idx))
  )

  (func $load_null (export "load_null") (result i32)
    (local $null (ref null $i8_array))
    (i32.load (type $i8_array) (local.get $null) (i32.const 0))
  )
)

;;
;; 32 bit round trip tests
;;

(assert_return (invoke "i32_set_and_get_i8" (i32.const 0)) (i32.const 0))
(assert_return (invoke "i32_set_and_get_i8" (i32.const 255)) (i32.const 255))
;; ensure high bits are ignored
(assert_return (invoke "i32_set_and_get_i8" (i32.const 0xFFFFFF00)) (i32.const 0))

(assert_return (invoke "i32_set_and_get_i16" (i32.const 0)) (i32.const 0))
(assert_return (invoke "i32_set_and_get_i16" (i32.const 65535)) (i32.const 65535))
;; ensure high bits are ignored
(assert_return (invoke "i32_set_and_get_i16" (i32.const 0xFFFF0000)) (i32.const 0))

(assert_return (invoke "i32_set_and_get_i32" (i32.const 0)) (i32.const 0))
(assert_return (invoke "i32_set_and_get_i32" (i32.const 1)) (i32.const 1))
(assert_return (invoke "i32_set_and_get_i32" (i32.const 256)) (i32.const 256))
(assert_return (invoke "i32_set_and_get_i32" (i32.const -1)) (i32.const -1))
(assert_return (invoke "i32_set_and_get_i32" (i32.const 2147483647)) (i32.const 2147483647))
(assert_return (invoke "i32_set_and_get_i32" (i32.const -2147483648)) (i32.const -2147483648))

(assert_return (invoke "set_and_get_f32" (f32.const 0)) (f32.const 0))
(assert_return (invoke "set_and_get_f32" (f32.const -1)) (f32.const -1))
(assert_return (invoke "set_and_get_f32" (f32.const 3.3)) (f32.const 3.3))
(assert_return (invoke "set_and_get_f32" (f32.const -2.000000238418579)) (f32.const -2.000000238418579))
(assert_return (invoke "set_and_get_f32" (f32.const nan)) (f32.const nan))
(assert_return (invoke "set_and_get_f32" (f32.const nan:0x123456)) (f32.const nan:0x123456))
(assert_return (invoke "set_and_get_f32" (f32.const -nan:0x654321)) (f32.const -nan:0x654321))

;;
;; 64 bit round trip tests
;;

(assert_return (invoke "i64_set_and_get_i8" (i64.const 0)) (i64.const 0))
(assert_return (invoke "i64_set_and_get_i8" (i64.const 255)) (i64.const 255))
;; ensure high bits are ignored
(assert_return (invoke "i64_set_and_get_i8" (i64.const 0xFFFFFFFFFFFFFF00)) (i64.const 0))

(assert_return (invoke "i64_set_and_get_i16" (i64.const 0)) (i64.const 0))
(assert_return (invoke "i64_set_and_get_i16" (i64.const 65535)) (i64.const 65535))
;; ensure high bits are ignored
(assert_return (invoke "i64_set_and_get_i16" (i64.const 0xFFFFFFFFFFFF0000)) (i64.const 0))

(assert_return (invoke "i64_set_and_get_i32" (i64.const 0)) (i64.const 0))
(assert_return (invoke "i64_set_and_get_i32" (i64.const 2147483647)) (i64.const 2147483647))
;; unsigned extend
(assert_return (invoke "i64_set_and_get_i32" (i64.const -2147483648)) (i64.const 2147483648))
;; ensure high bits are ignored
(assert_return (invoke "i64_set_and_get_i32" (i64.const 0xFFFFFFFF00000000)) (i64.const 0))

(assert_return (invoke "i64_set_and_get_i64" (i64.const 0)) (i64.const 0))
(assert_return (invoke "i64_set_and_get_i64" (i64.const 9223372036854775807)) (i64.const 9223372036854775807))
(assert_return (invoke "i64_set_and_get_i64" (i64.const -9223372036854775808)) (i64.const -9223372036854775808))

(assert_return (invoke "set_and_get_f64" (f64.const 0)) (f64.const 0))
(assert_return (invoke "set_and_get_f64" (f64.const -1)) (f64.const -1))
(assert_return (invoke "set_and_get_f64" (f64.const 3.3)) (f64.const 3.3))
(assert_return (invoke "set_and_get_f64" (f64.const -2.00000000000000044409)) (f64.const -2.00000000000000044409))
(assert_return (invoke "set_and_get_f64" (f64.const nan)) (f64.const nan))
(assert_return (invoke "set_and_get_f64" (f64.const nan:0x123456789abcd)) (f64.const nan:0x123456789abcd))
(assert_return (invoke "set_and_get_f64" (f64.const -nan:0xedcba98765432)) (f64.const -nan:0xedcba98765432))

;;
;; Byte-wise store and unaligned store tests (32 bit)
;;

(invoke "i32_set_i32" (i32.const 0) (i32.const 0x00000000)) ;; clear
(invoke "i32_set_i16" (i32.const 0) (i32.const 0x1234))
(assert_return (invoke "get_array_4_byte" (i32.const 0)) (i32.const 0x34))
(assert_return (invoke "get_array_4_byte" (i32.const 1)) (i32.const 0x12))
(assert_return (invoke "get_array_4_byte" (i32.const 2)) (i32.const 0x00))
(assert_return (invoke "get_array_4_byte" (i32.const 3)) (i32.const 0x00))

(invoke "i32_set_i32" (i32.const 0) (i32.const 0x12345678))
(assert_return (invoke "get_array_4_byte" (i32.const 0)) (i32.const 0x78))
(assert_return (invoke "get_array_4_byte" (i32.const 1)) (i32.const 0x56))
(assert_return (invoke "get_array_4_byte" (i32.const 2)) (i32.const 0x34))
(assert_return (invoke "get_array_4_byte" (i32.const 3)) (i32.const 0x12))

(invoke "i32_set_i16" (i32.const 1) (i32.const 0xABCD))
(assert_return (invoke "get_array_4_byte" (i32.const 0)) (i32.const 0x78))
(assert_return (invoke "get_array_4_byte" (i32.const 1)) (i32.const 0xCD))
(assert_return (invoke "get_array_4_byte" (i32.const 2)) (i32.const 0xAB))
(assert_return (invoke "get_array_4_byte" (i32.const 3)) (i32.const 0x12))

;;
;; Byte-wise store and unaligned store tests (64 bit)
;;

(invoke "i64_set_i64" (i32.const 0) (i64.const 0x123456789ABCDEF0))
(assert_return (invoke "get_array_8_byte" (i32.const 0)) (i32.const 0xF0))
(assert_return (invoke "get_array_8_byte" (i32.const 1)) (i32.const 0xDE))
(assert_return (invoke "get_array_8_byte" (i32.const 2)) (i32.const 0xBC))
(assert_return (invoke "get_array_8_byte" (i32.const 3)) (i32.const 0x9A))
(assert_return (invoke "get_array_8_byte" (i32.const 4)) (i32.const 0x78))
(assert_return (invoke "get_array_8_byte" (i32.const 5)) (i32.const 0x56))
(assert_return (invoke "get_array_8_byte" (i32.const 6)) (i32.const 0x34))
(assert_return (invoke "get_array_8_byte" (i32.const 7)) (i32.const 0x12))

(invoke "i64_set_i32" (i32.const 3) (i64.const 0x11223344))
(assert_return (invoke "get_array_8_byte" (i32.const 0)) (i32.const 0xF0))
(assert_return (invoke "get_array_8_byte" (i32.const 1)) (i32.const 0xDE))
(assert_return (invoke "get_array_8_byte" (i32.const 2)) (i32.const 0xBC))
(assert_return (invoke "get_array_8_byte" (i32.const 3)) (i32.const 0x44))
(assert_return (invoke "get_array_8_byte" (i32.const 4)) (i32.const 0x33))
(assert_return (invoke "get_array_8_byte" (i32.const 5)) (i32.const 0x22))
(assert_return (invoke "get_array_8_byte" (i32.const 6)) (i32.const 0x11))
(assert_return (invoke "get_array_8_byte" (i32.const 7)) (i32.const 0x12))

;;
;; Byte-wise load tests
;;

(invoke "i32_set_i8" (i32.const 0) (i32.const 0x12))
(invoke "i32_set_i8" (i32.const 1) (i32.const 0x34))
(invoke "i32_set_i8" (i32.const 2) (i32.const 0x56))
(invoke "i32_set_i8" (i32.const 3) (i32.const 0x78))

(assert_return (invoke "load_i32_16_u" (i32.const 0)) (i32.const 0x3412))
(assert_return (invoke "load_i32_16_s" (i32.const 0)) (i32.const 0x3412))

;; Test sign extension
(invoke "i32_set_i8" (i32.const 0) (i32.const 0xFF))
(invoke "i32_set_i8" (i32.const 1) (i32.const 0x7F))
(assert_return (invoke "load_i32_16_u" (i32.const 0)) (i32.const 0x7FFF))
(assert_return (invoke "load_i32_16_s" (i32.const 0)) (i32.const 0x7FFF))

(invoke "i32_set_i8" (i32.const 1) (i32.const 0xFF))
(assert_return (invoke "load_i32_16_u" (i32.const 0)) (i32.const 0xFFFF))
(assert_return (invoke "load_i32_16_s" (i32.const 0)) (i32.const -1))

(assert_return (invoke "load_i32" (i32.const 0)) (i32.const 0x7856FFFF))

;;
;; Bounds checks (32 bit with a 4-byte array)
;;

(invoke "i32_set_i32" (i32.const 0) (i32.const 0))

;; i32_set_i8: Writes 1 byte
;; Valid range: [0, 3]
(assert_trap (invoke "i32_set_i8" (i32.const -1) (i32.const 0)) "out of bounds")
(assert_return (invoke "i32_set_i8" (i32.const 0) (i32.const 0)))
(assert_return (invoke "i32_set_i8" (i32.const 1) (i32.const 0)))
(assert_return (invoke "i32_set_i8" (i32.const 2) (i32.const 0)))
(assert_return (invoke "i32_set_i8" (i32.const 3) (i32.const 0)))
(assert_trap (invoke "i32_set_i8" (i32.const 4) (i32.const 0xFFFF)) "out of bounds")

;; i32_set_i16: Writes 2 bytes
;; Valid range: offset + 2 <= 4 -> Max offset 2
(assert_trap (invoke "i32_set_i16" (i32.const -1) (i32.const 0)) "out of bounds")
(assert_return (invoke "i32_set_i16" (i32.const 0) (i32.const 0)))
(assert_return (invoke "i32_set_i16" (i32.const 1) (i32.const 0)))
(assert_return (invoke "i32_set_i16" (i32.const 2) (i32.const 0)))
(assert_trap (invoke "i32_set_i16" (i32.const 3) (i32.const 0xFFFF)) "out of bounds")
(assert_return (invoke "get_array_4_byte" (i32.const 3)) (i32.const 0))

;; i32_set_i32: Writes 4 bytes
;; Valid range: offset + 4 <= 4 -> Max offset 0
(assert_trap (invoke "i32_set_i32" (i32.const -1) (i32.const 0)) "out of bounds")
(assert_return (invoke "i32_set_i32" (i32.const 0) (i32.const 0)))
(assert_trap (invoke "i32_set_i32" (i32.const 1) (i32.const 0xFFFFFFFF)) "out of bounds")
(assert_return (invoke "get_array_4_byte" (i32.const 1)) (i32.const 0))

;; f32_set: Writes 4 bytes
;; Valid range: offset + 4 <= 4 -> Max offset 0
(assert_trap (invoke "f32_set" (i32.const -1) (f32.const 0)) "out of bounds")
(assert_return (invoke "f32_set" (i32.const 0) (f32.const 0)))
(assert_trap (invoke "f32_set" (i32.const 1) (f32.const 1.0)) "out of bounds")
(assert_return (invoke "get_array_4_byte" (i32.const 1)) (i32.const 0))

;;
;; Bounds checks (64 bit with an 8-byte array)
;;

(invoke "i64_set_i64" (i32.const 0) (i64.const 0))

;; i64_set_i8: Writes 1 byte
;; Valid range: [0, 7]
(assert_trap (invoke "i64_set_i8" (i32.const -1) (i64.const 0)) "out of bounds")
(assert_return (invoke "i64_set_i8" (i32.const 0) (i64.const 0)))
(assert_return (invoke "i64_set_i8" (i32.const 1) (i64.const 0)))
(assert_return (invoke "i64_set_i8" (i32.const 6) (i64.const 0)))
(assert_return (invoke "i64_set_i8" (i32.const 7) (i64.const 0)))
(assert_trap (invoke "i64_set_i8" (i32.const 8) (i64.const 0xFFFF)) "out of bounds")

;; i64_set_i16: Writes 2 bytes
;; Valid range: offset + 2 <= 8 -> Max offset 6
(assert_trap (invoke "i64_set_i16" (i32.const -1) (i64.const 0)) "out of bounds")
(assert_return (invoke "i64_set_i16" (i32.const 0) (i64.const 0)))
(assert_return (invoke "i64_set_i16" (i32.const 1) (i64.const 0)))
(assert_return (invoke "i64_set_i16" (i32.const 5) (i64.const 0)))
(assert_return (invoke "i64_set_i16" (i32.const 6) (i64.const 0)))
(assert_trap (invoke "i64_set_i16" (i32.const 7) (i64.const 0xFFFF)) "out of bounds")
(assert_return (invoke "get_array_8_byte" (i32.const 7)) (i32.const 0))

;; i64_set_i32: Writes 4 bytes
;; Valid range: offset + 4 <= 8 -> Max offset 4
(assert_trap (invoke "i64_set_i32" (i32.const -1) (i64.const 0)) "out of bounds")
(assert_return (invoke "i64_set_i32" (i32.const 0) (i64.const 0)))
(assert_return (invoke "i64_set_i32" (i32.const 1) (i64.const 0)))
(assert_return (invoke "i64_set_i32" (i32.const 3) (i64.const 0)))
(assert_return (invoke "i64_set_i32" (i32.const 4) (i64.const 0)))
(assert_trap (invoke "i64_set_i32" (i32.const 5) (i64.const 0xFFFFFFFF)) "out of bounds")
(assert_return (invoke "get_array_8_byte" (i32.const 5)) (i32.const 0))

;; i64_set_i64: Writes 8 bytes
;; Valid range: offset + 8 <= 8 -> Max offset 0
(assert_trap (invoke "i64_set_i64" (i32.const -1) (i64.const 0)) "out of bounds")
(assert_return (invoke "i64_set_i64" (i32.const 0) (i64.const 0)))
(assert_trap (invoke "i64_set_i64" (i32.const 1) (i64.const 0xFFFFFFFFFFFFFFFF)) "out of bounds")
(assert_return (invoke "get_array_8_byte" (i32.const 1)) (i32.const 0))

;; f64_set: Writes 8 bytes
;; Valid range: offset + 8 <= 8 -> Max offset 0
(assert_trap (invoke "f64_set" (i32.const -1) (f64.const 0)) "out of bounds")
(assert_return (invoke "f64_set" (i32.const 0) (f64.const 0)))
(assert_trap (invoke "f64_set" (i32.const 1) (f64.const 1.0)) "out of bounds")
(assert_return (invoke "get_array_8_byte" (i32.const 1)) (i32.const 0))


(assert_invalid
  (module
    (type $a (array i8))
    (func (export "i32_set_immutable") (param $a (ref $a))
      (i32.store (type $a) (local.get $a) (i32.const 0) (i32.const 1))
    )
  )
  "array store type must be mutable"
)

(assert_invalid
  (module
    (type $a (array (mut anyref)))
    (func (export "i32_set_mut_anyref") (param $a (ref $a))
      (i32.store (type $a) (local.get $a) (i32.const 0) (i32.const 1))
    )
  )
  "array store type must be a numeric type"
)

(assert_invalid
  (module
    (type $a (array anyref))
    (func (export "i32_load_anyref") (param $a (ref $a))
      (drop (i32.load (type $a) (local.get $a) (i32.const 0)))
    )
  )
  "array load type must be a numeric type"
)

(assert_invalid
  (module
    (type $s (struct (field (mut i32))))
    (func (export "i32_store_struct") (param $s (ref $s))
      (i32.store (type $s) (local.get $s) (i32.const 0) (i32.const 1))
    )
  )
  "array store target should be an array reference"
)

;; New OOB Load Tests
(assert_trap (invoke "load_i32_16_u" (i32.const 3)) "out of bounds")
(assert_trap (invoke "load_i32" (i32.const 1)) "out of bounds")
(assert_trap (invoke "load_i64" (i32.const 1)) "out of bounds")

;; Null reference for load
(assert_trap (invoke "load_null") "null array")

;; Unaligned reads
(invoke "i32_set_i8" (i32.const 0) (i32.const 0x12))
(invoke "i32_set_i8" (i32.const 1) (i32.const 0x34))
(invoke "i32_set_i8" (i32.const 2) (i32.const 0x56))
(invoke "i32_set_i8" (i32.const 3) (i32.const 0x78))

(assert_return (invoke "load_i32_16_u" (i32.const 1)) (i32.const 0x5634))
(assert_return (invoke "load_i32_16_u" (i32.const 2)) (i32.const 0x7856))

;; Null dereference

(module
  (type $t (array (mut i8)))
  (func (export "i32.store_array_null")
    (local (ref null $t)) (i32.store (type $t) (local.get 0) (i32.const 0) (i32.const 0))
  )
)

(assert_trap (invoke "i32.store_array_null") "null array")

;;
;; Tests for all numeric and vector array types (i16, i32, i64, f32, f64, v128)
;;

(module
  (type $i16_array (array (mut i16)))
  (type $i32_array (array (mut i32)))
  (type $i64_array (array (mut i64)))
  (type $f32_array (array (mut f32)))
  (type $f64_array (array (mut f64)))
  (type $v128_array (array (mut v128)))

  (global $arr_i16 (ref $i16_array) (array.new_default $i16_array (i32.const 4))) ;; 4 elements = 8 bytes
  (global $arr_i32 (ref $i32_array) (array.new_default $i32_array (i32.const 4))) ;; 4 elements = 16 bytes
  (global $arr_i64 (ref $i64_array) (array.new_default $i64_array (i32.const 2))) ;; 2 elements = 16 bytes
  (global $arr_f32 (ref $f32_array) (array.new_default $f32_array (i32.const 4))) ;; 4 elements = 16 bytes
  (global $arr_f64 (ref $f64_array) (array.new_default $f64_array (i32.const 2))) ;; 2 elements = 16 bytes
  (global $arr_v128 (ref $v128_array) (array.new_default $v128_array (i32.const 2))) ;; 2 elements = 32 bytes

  ;; $i16_array functions
  (func (export "i16_len") (result i32)
    (array.len (global.get $arr_i16))
  )
  (func (export "i16_get") (param $i i32) (result i32)
    (array.get_u $i16_array (global.get $arr_i16) (local.get $i))
  )
  (func (export "i16_set") (param $i i32) (param $v i32)
    (array.set $i16_array (global.get $arr_i16) (local.get $i) (local.get $v))
  )
  (func (export "i16_store32") (param $addr i32) (param $val i32)
    (i32.store (type $i16_array) (global.get $arr_i16) (local.get $addr) (local.get $val))
  )
  (func (export "i16_load32") (param $addr i32) (result i32)
    (i32.load (type $i16_array) (global.get $arr_i16) (local.get $addr))
  )
  (func (export "i16_store64") (param $addr i32) (param $val i64)
    (i64.store (type $i16_array) (global.get $arr_i16) (local.get $addr) (local.get $val))
  )
  (func (export "i16_load64") (param $addr i32) (result i64)
    (i64.load (type $i16_array) (global.get $arr_i16) (local.get $addr))
  )
  (func (export "i16_store8") (param $addr i32) (param $val i32)
    (i32.store8 (type $i16_array) (global.get $arr_i16) (local.get $addr) (local.get $val))
  )
  (func (export "i16_load8_u") (param $addr i32) (result i32)
    (i32.load8_u (type $i16_array) (global.get $arr_i16) (local.get $addr))
  )
  (func (export "i16_load16_s") (param $addr i32) (result i32)
    (i32.load16_s (type $i16_array) (global.get $arr_i16) (local.get $addr))
  )
  (func (export "i16_store_with_offset") (param $addr i32) (param $val i32)
    (i32.store16 (type $i16_array) offset=2 (global.get $arr_i16) (local.get $addr) (local.get $val))
  )
  (func (export "i16_load_with_offset") (param $addr i32) (result i32)
    (i32.load16_u (type $i16_array) offset=2 (global.get $arr_i16) (local.get $addr))
  )

  ;; $i32_array functions
  (func (export "i32_len") (result i32)
    (array.len (global.get $arr_i32))
  )
  (func (export "i32_get") (param $i i32) (result i32)
    (array.get $i32_array (global.get $arr_i32) (local.get $i))
  )
  (func (export "i32_set") (param $i i32) (param $v i32)
    (array.set $i32_array (global.get $arr_i32) (local.get $i) (local.get $v))
  )
  (func (export "i32_store8") (param $addr i32) (param $v i32)
    (i32.store8 (type $i32_array) (global.get $arr_i32) (local.get $addr) (local.get $v))
  )
  (func (export "i32_load8_u") (param $addr i32) (result i32)
    (i32.load8_u (type $i32_array) (global.get $arr_i32) (local.get $addr))
  )
  (func (export "i32_store16") (param $addr i32) (param $v i32)
    (i32.store16 (type $i32_array) (global.get $arr_i32) (local.get $addr) (local.get $v))
  )
  (func (export "i32_load16_u") (param $addr i32) (result i32)
    (i32.load16_u (type $i32_array) (global.get $arr_i32) (local.get $addr))
  )
  (func (export "i32_store32") (param $addr i32) (param $v i32)
    (i32.store (type $i32_array) (global.get $arr_i32) (local.get $addr) (local.get $v))
  )
  (func (export "i32_load32") (param $addr i32) (result i32)
    (i32.load (type $i32_array) (global.get $arr_i32) (local.get $addr))
  )
  (func (export "i32_store64") (param $addr i32) (param $v i64)
    (i64.store (type $i32_array) (global.get $arr_i32) (local.get $addr) (local.get $v))
  )
  (func (export "i32_load64") (param $addr i32) (result i64)
    (i64.load (type $i32_array) (global.get $arr_i32) (local.get $addr))
  )
  (func (export "i32_store_v128") (param $addr i32) (param $v v128)
    (v128.store (type $i32_array) (global.get $arr_i32) (local.get $addr) (local.get $v))
  )
  (func (export "i32_load_v128") (param $addr i32) (result v128)
    (v128.load (type $i32_array) (global.get $arr_i32) (local.get $addr))
  )

  ;; $i64_array functions
  (func (export "i64_len") (result i32)
    (array.len (global.get $arr_i64))
  )
  (func (export "i64_get") (param $i i32) (result i64)
    (array.get $i64_array (global.get $arr_i64) (local.get $i))
  )
  (func (export "i64_set") (param $i i32) (param $v i64)
    (array.set $i64_array (global.get $arr_i64) (local.get $i) (local.get $v))
  )
  (func (export "i64_store8") (param $addr i32) (param $v i64)
    (i64.store8 (type $i64_array) (global.get $arr_i64) (local.get $addr) (local.get $v))
  )
  (func (export "i64_load8_u") (param $addr i32) (result i64)
    (i64.load8_u (type $i64_array) (global.get $arr_i64) (local.get $addr))
  )
  (func (export "i64_store32") (param $addr i32) (param $v i64)
    (i64.store32 (type $i64_array) (global.get $arr_i64) (local.get $addr) (local.get $v))
  )
  (func (export "i64_load32_s") (param $addr i32) (result i64)
    (i64.load32_s (type $i64_array) (global.get $arr_i64) (local.get $addr))
  )
  (func (export "i64_load32_u") (param $addr i32) (result i64)
    (i64.load32_u (type $i64_array) (global.get $arr_i64) (local.get $addr))
  )
  (func (export "i64_store64") (param $addr i32) (param $v i64)
    (i64.store (type $i64_array) (global.get $arr_i64) (local.get $addr) (local.get $v))
  )
  (func (export "i64_load64") (param $addr i32) (result i64)
    (i64.load (type $i64_array) (global.get $arr_i64) (local.get $addr))
  )
  (func (export "i64_store_v128") (param $addr i32) (param $v v128)
    (v128.store (type $i64_array) (global.get $arr_i64) (local.get $addr) (local.get $v))
  )
  (func (export "i64_load_v128") (param $addr i32) (result v128)
    (v128.load (type $i64_array) (global.get $arr_i64) (local.get $addr))
  )

  ;; $f32_array functions
  (func (export "f32_len") (result i32)
    (array.len (global.get $arr_f32))
  )
  (func (export "f32_get") (param $i i32) (result f32)
    (array.get $f32_array (global.get $arr_f32) (local.get $i))
  )
  (func (export "f32_set") (param $i i32) (param $v f32)
    (array.set $f32_array (global.get $arr_f32) (local.get $i) (local.get $v))
  )
  (func (export "f32_store") (param $addr i32) (param $v f32)
    (f32.store (type $f32_array) (global.get $arr_f32) (local.get $addr) (local.get $v))
  )
  (func (export "f32_load") (param $addr i32) (result f32)
    (f32.load (type $f32_array) (global.get $arr_f32) (local.get $addr))
  )
  (func (export "f32_store_i32") (param $addr i32) (param $v i32)
    (i32.store (type $f32_array) (global.get $arr_f32) (local.get $addr) (local.get $v))
  )
  (func (export "f32_load_i32") (param $addr i32) (result i32)
    (i32.load (type $f32_array) (global.get $arr_f32) (local.get $addr))
  )
  (func (export "f32_store_f64") (param $addr i32) (param $v f64)
    (f64.store (type $f32_array) (global.get $arr_f32) (local.get $addr) (local.get $v))
  )
  (func (export "f32_load_f64") (param $addr i32) (result f64)
    (f64.load (type $f32_array) (global.get $arr_f32) (local.get $addr))
  )

  ;; $f64_array functions
  (func (export "f64_len") (result i32)
    (array.len (global.get $arr_f64))
  )
  (func (export "f64_get") (param $i i32) (result f64)
    (array.get $f64_array (global.get $arr_f64) (local.get $i))
  )
  (func (export "f64_set") (param $i i32) (param $v f64)
    (array.set $f64_array (global.get $arr_f64) (local.get $i) (local.get $v))
  )
  (func (export "f64_store") (param $addr i32) (param $v f64)
    (f64.store (type $f64_array) (global.get $arr_f64) (local.get $addr) (local.get $v))
  )
  (func (export "f64_load") (param $addr i32) (result f64)
    (f64.load (type $f64_array) (global.get $arr_f64) (local.get $addr))
  )
  (func (export "f64_store_i64") (param $addr i32) (param $v i64)
    (i64.store (type $f64_array) (global.get $arr_f64) (local.get $addr) (local.get $v))
  )
  (func (export "f64_load_i64") (param $addr i32) (result i64)
    (i64.load (type $f64_array) (global.get $arr_f64) (local.get $addr))
  )

  ;; $v128_array functions
  (func (export "v128_len") (result i32)
    (array.len (global.get $arr_v128))
  )
  (func (export "v128_get") (param $i i32) (result v128)
    (array.get $v128_array (global.get $arr_v128) (local.get $i))
  )
  (func (export "v128_set") (param $i i32) (param $v v128)
    (array.set $v128_array (global.get $arr_v128) (local.get $i) (local.get $v))
  )
  (func (export "v128_store") (param $addr i32) (param $v v128)
    (v128.store (type $v128_array) (global.get $arr_v128) (local.get $addr) (local.get $v))
  )
  (func (export "v128_load") (param $addr i32) (result v128)
    (v128.load (type $v128_array) (global.get $arr_v128) (local.get $addr))
  )
  (func (export "v128_store_i32") (param $addr i32) (param $v i32)
    (i32.store (type $v128_array) (global.get $arr_v128) (local.get $addr) (local.get $v))
  )
  (func (export "v128_load_i32") (param $addr i32) (result i32)
    (i32.load (type $v128_array) (global.get $arr_v128) (local.get $addr))
  )
  (func (export "v128_store_i64") (param $addr i32) (param $v i64)
    (i64.store (type $v128_array) (global.get $arr_v128) (local.get $addr) (local.get $v))
  )
  (func (export "v128_load_i64") (param $addr i32) (result i64)
    (i64.load (type $v128_array) (global.get $arr_v128) (local.get $addr))
  )
)

;;
;; Test i16 array operations
;;
(assert_return (invoke "i16_len") (i32.const 4))
(invoke "i16_store32" (i32.const 0) (i32.const 0x12345678))
(assert_return (invoke "i16_get" (i32.const 0)) (i32.const 0x5678))
(assert_return (invoke "i16_get" (i32.const 1)) (i32.const 0x1234))
(invoke "i16_set" (i32.const 0) (i32.const 0xAAAA))
(assert_return (invoke "i16_load32" (i32.const 0)) (i32.const 0x1234AAAA))

;; Unaligned store/load across elements in i16 array
(invoke "i16_store32" (i32.const 1) (i32.const 0x01020304))
(assert_return (invoke "i16_load8_u" (i32.const 1)) (i32.const 0x04))
(assert_return (invoke "i16_load8_u" (i32.const 2)) (i32.const 0x03))
(assert_return (invoke "i16_load8_u" (i32.const 3)) (i32.const 0x02))
(assert_return (invoke "i16_load8_u" (i32.const 4)) (i32.const 0x01))
(assert_return (invoke "i16_load16_s" (i32.const 2)) (i32.const 0x0203))

;; 64-bit store across entire 8-byte i16 array
(invoke "i16_store64" (i32.const 0) (i64.const 0x0123456789ABCDEF))
(assert_return (invoke "i16_load64" (i32.const 0)) (i64.const 0x0123456789ABCDEF))
(assert_return (invoke "i16_get" (i32.const 0)) (i32.const 0xCDEF))
(assert_return (invoke "i16_get" (i32.const 1)) (i32.const 0x89AB))
(assert_return (invoke "i16_get" (i32.const 2)) (i32.const 0x4567))
(assert_return (invoke "i16_get" (i32.const 3)) (i32.const 0x0123))

;; Offset testing on i16 array
(invoke "i16_store_with_offset" (i32.const 2) (i32.const 0xBEEF))
(assert_return (invoke "i16_load_with_offset" (i32.const 2)) (i32.const 0xBEEF))
(assert_return (invoke "i16_get" (i32.const 2)) (i32.const 0xBEEF))

;; Bounds checks on i16 array (8 bytes total)
(assert_trap (invoke "i16_load32" (i32.const -1)) "out of bounds")
(assert_return (invoke "i16_load32" (i32.const 4)) (i32.const 0x0123BEEF))
(assert_trap (invoke "i16_load32" (i32.const 5)) "out of bounds")
(assert_return (invoke "i16_load64" (i32.const 0)) (i64.const 0x0123BEEF89ABCDEF))
(assert_trap (invoke "i16_load64" (i32.const 1)) "out of bounds")
(assert_trap (invoke "i16_store32" (i32.const 5) (i32.const 0)) "out of bounds")
(assert_trap (invoke "i16_store64" (i32.const 1) (i64.const 0)) "out of bounds")
(assert_trap (invoke "i16_load_with_offset" (i32.const 5)) "out of bounds")

;;
;; Test i32 array operations
;;
(assert_return (invoke "i32_len") (i32.const 4))
(invoke "i32_store_v128" (i32.const 0) (v128.const i32x4 1 2 3 4))
(assert_return (invoke "i32_get" (i32.const 0)) (i32.const 1))
(assert_return (invoke "i32_get" (i32.const 1)) (i32.const 2))
(assert_return (invoke "i32_get" (i32.const 2)) (i32.const 3))
(assert_return (invoke "i32_get" (i32.const 3)) (i32.const 4))
(assert_return (invoke "i32_load_v128" (i32.const 0)) (v128.const i32x4 1 2 3 4))

(assert_return (invoke "i32_load64" (i32.const 0)) (i64.const 0x0000000200000001))
(assert_return (invoke "i32_load64" (i32.const 8)) (i64.const 0x0000000400000003))

(invoke "i32_store8" (i32.const 0) (i32.const 0xFF))
(assert_return (invoke "i32_load8_u" (i32.const 0)) (i32.const 0xFF))
(assert_return (invoke "i32_get" (i32.const 0)) (i32.const 0x000000FF))

(invoke "i32_store16" (i32.const 2) (i32.const 0xABCD))
(assert_return (invoke "i32_load16_u" (i32.const 2)) (i32.const 0xABCD))
(assert_return (invoke "i32_get" (i32.const 0)) (i32.const 0xABCD00FF))

(invoke "i32_set" (i32.const 3) (i32.const 0x12345678))
(assert_return (invoke "i32_load32" (i32.const 12)) (i32.const 0x12345678))

;; Bounds checks on i32 array (16 bytes total)
(assert_trap (invoke "i32_load_v128" (i32.const -1)) "out of bounds")
(assert_return (invoke "i32_load_v128" (i32.const 0)) (v128.const i32x4 0xABCD00FF 2 3 0x12345678))
(assert_trap (invoke "i32_load_v128" (i32.const 1)) "out of bounds")
(assert_return (invoke "i32_load64" (i32.const 8)) (i64.const 0x1234567800000003))
(assert_trap (invoke "i32_load64" (i32.const 9)) "out of bounds")
(assert_trap (invoke "i32_store_v128" (i32.const 1) (v128.const i32x4 0 0 0 0)) "out of bounds")
(assert_trap (invoke "i32_store64" (i32.const 9) (i64.const 0)) "out of bounds")

;;
;; Test i64 array operations
;;
(assert_return (invoke "i64_len") (i32.const 2))
(invoke "i64_set" (i32.const 0) (i64.const 0x0123456789ABCDEF))
(invoke "i64_set" (i32.const 1) (i64.const 0x1122334455667788))

(assert_return (invoke "i64_load32_u" (i32.const 0)) (i64.const 0x89ABCDEF))
(assert_return (invoke "i64_load32_s" (i32.const 0)) (i64.const -1985229329))
(assert_return (invoke "i64_load32_u" (i32.const 4)) (i64.const 0x01234567))
(assert_return (invoke "i64_load8_u" (i32.const 7)) (i64.const 0x01))

;; Unaligned store into i64 array
(invoke "i64_store32" (i32.const 2) (i64.const 0xDEADBEEF))
(assert_return (invoke "i64_load32_u" (i32.const 2)) (i64.const 0xDEADBEEF))
(assert_return (invoke "i64_load64" (i32.const 0)) (i64.const 0x0123DEADBEEFCDEF))

(invoke "i64_store_v128" (i32.const 0) (v128.const i64x2 0xAAAABBBBCCCCDDDD 0x1111222233334444))
(assert_return (invoke "i64_get" (i32.const 0)) (i64.const 0xAAAABBBBCCCCDDDD))
(assert_return (invoke "i64_get" (i32.const 1)) (i64.const 0x1111222233334444))
(assert_return (invoke "i64_load_v128" (i32.const 0)) (v128.const i64x2 0xAAAABBBBCCCCDDDD 0x1111222233334444))

;; Bounds checks on i64 array (16 bytes total)
(assert_trap (invoke "i64_load_v128" (i32.const 1)) "out of bounds")
(assert_trap (invoke "i64_load64" (i32.const 9)) "out of bounds")
(assert_return (invoke "i64_load64" (i32.const 8)) (i64.const 0x1111222233334444))

;;
;; Test f32 array operations
;;
(assert_return (invoke "f32_len") (i32.const 4))
(invoke "f32_store" (i32.const 0) (f32.const 42.5))
(assert_return (invoke "f32_get" (i32.const 0)) (f32.const 42.5))
(invoke "f32_set" (i32.const 1) (f32.const -10.25))
(assert_return (invoke "f32_load" (i32.const 4)) (f32.const -10.25))

;; Store f64 across 2 f32 slots
(invoke "f32_store_f64" (i32.const 0) (f64.const 12345.6789))
(assert_return (invoke "f32_load_f64" (i32.const 0)) (f64.const 12345.6789))

;; Store bitcast i32 into f32 slot
(invoke "f32_store_i32" (i32.const 8) (i32.const 0x3F800000))
(assert_return (invoke "f32_get" (i32.const 2)) (f32.const 1.0))
(assert_return (invoke "f32_load" (i32.const 8)) (f32.const 1.0))

;; Bounds checks on f32 array (16 bytes total)
(assert_trap (invoke "f32_load_f64" (i32.const 9)) "out of bounds")
(invoke "f32_store_f64" (i32.const 8) (f64.const 99.0))
(assert_return (invoke "f32_load_f64" (i32.const 8)) (f64.const 99.0))
(assert_trap (invoke "f32_store_f64" (i32.const 9) (f64.const 0)) "out of bounds")

;;
;; Test f64 array operations
;;
(assert_return (invoke "f64_len") (i32.const 2))
(invoke "f64_set" (i32.const 0) (f64.const 1.23456789))
(assert_return (invoke "f64_load" (i32.const 0)) (f64.const 1.23456789))

;; Store i64 bits into f64 slot
(invoke "f64_store_i64" (i32.const 8) (i64.const 0x400921FB54442D18)) ;; pi
(assert_return (invoke "f64_get" (i32.const 1)) (f64.const 3.141592653589793))
(assert_return (invoke "f64_load" (i32.const 8)) (f64.const 3.141592653589793))

;; Bounds checks on f64 array (16 bytes total)
(assert_trap (invoke "f64_load" (i32.const 9)) "out of bounds")
(assert_return (invoke "f64_load" (i32.const 8)) (f64.const 3.141592653589793))
(assert_trap (invoke "f64_store" (i32.const 9) (f64.const 0)) "out of bounds")

;;
;; Test v128 array operations
;;
(assert_return (invoke "v128_len") (i32.const 2))
(invoke "v128_set" (i32.const 0) (v128.const i32x4 100 200 300 400))
(assert_return (invoke "v128_load" (i32.const 0)) (v128.const i32x4 100 200 300 400))

;; Store individual i32s into second vector
(invoke "v128_store_i32" (i32.const 16) (i32.const 11))
(invoke "v128_store_i32" (i32.const 20) (i32.const 22))
(invoke "v128_store_i32" (i32.const 24) (i32.const 33))
(invoke "v128_store_i32" (i32.const 28) (i32.const 44))
(assert_return (invoke "v128_get" (i32.const 1)) (v128.const i32x4 11 22 33 44))
(assert_return (invoke "v128_load" (i32.const 16)) (v128.const i32x4 11 22 33 44))

;; Bounds checks on v128 array (32 bytes total)
(assert_return (invoke "v128_load" (i32.const 16)) (v128.const i32x4 11 22 33 44))
(assert_trap (invoke "v128_load" (i32.const 17)) "out of bounds")
(assert_return (invoke "v128_load_i32" (i32.const 28)) (i32.const 44))
(assert_trap (invoke "v128_load_i32" (i32.const 29)) "out of bounds")
(assert_trap (invoke "v128_store" (i32.const 17) (v128.const i32x4 0 0 0 0)) "out of bounds")

;;
;; Test immutable array loads
;;

(module
  (type $imm_i8 (array i8))
  (type $imm_i16 (array i16))
  (type $imm_i32 (array i32))
  (type $imm_i64 (array i64))
  (type $imm_f32 (array f32))
  (type $imm_f64 (array f64))
  (type $imm_v128 (array v128))

  (func (export "test_imm_i8") (result i32)
    (local $arr (ref $imm_i8))
    (local.set $arr
      (array.new_fixed $imm_i8 4 (i32.const 0x12) (i32.const 0x34) (i32.const 0x56) (i32.const 0x78))
    )
    (i32.load (type $imm_i8) (local.get $arr) (i32.const 0))
  )

  (func (export "test_imm_i16") (result i32)
    (local $arr (ref $imm_i16))
    (local.set $arr
      (array.new_fixed $imm_i16 2 (i32.const 0x1234) (i32.const 0x5678))
    )
    (i32.load (type $imm_i16) (local.get $arr) (i32.const 0))
  )

  (func (export "test_imm_i32") (result i64)
    (local $arr (ref $imm_i32))
    (local.set $arr
      (array.new_fixed $imm_i32 2 (i32.const 0x12345678) (i32.const 0x0ABCDEF0))
    )
    (i64.load (type $imm_i32) (local.get $arr) (i32.const 0))
  )

  (func (export "test_imm_i64") (result i32)
    (local $arr (ref $imm_i64))
    (local.set $arr
      (array.new_fixed $imm_i64 2 (i64.const 0x1122334455667788) (i64.const 0x99AABBCCDDEEFF00))
    )
    (i32.load (type $imm_i64) offset=4 (local.get $arr) (i32.const 0))
  )

  (func (export "test_imm_f32") (result f32)
    (local $arr (ref $imm_f32))
    (local.set $arr
      (array.new_fixed $imm_f32 2 (f32.const 1.5) (f32.const 2.5))
    )
    (f32.load (type $imm_f32) offset=4 (local.get $arr) (i32.const 0))
  )

  (func (export "test_imm_f64") (result f64)
    (local $arr (ref $imm_f64))
    (local.set $arr
      (array.new_fixed $imm_f64 2 (f64.const 3.14159) (f64.const 2.71828))
    )
    (f64.load (type $imm_f64) (local.get $arr) (i32.const 0))
  )

  (func (export "test_imm_v128") (result v128)
    (local $arr (ref $imm_v128))
    (local.set $arr
      (array.new_fixed $imm_v128 1 (v128.const i32x4 10 20 30 40))
    )
    (v128.load (type $imm_v128) (local.get $arr) (i32.const 0))
  )
)

(assert_return (invoke "test_imm_i8") (i32.const 0x78563412))
(assert_return (invoke "test_imm_i16") (i32.const 0x56781234))
(assert_return (invoke "test_imm_i32") (i64.const 0x0ABCDEF012345678))
(assert_return (invoke "test_imm_i64") (i32.const 0x11223344))
(assert_return (invoke "test_imm_f32") (f32.const 2.5))
(assert_return (invoke "test_imm_f64") (f64.const 3.14159))
(assert_return (invoke "test_imm_v128") (v128.const i32x4 10 20 30 40))


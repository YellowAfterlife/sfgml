package haxe;
import gml.Lib;
import gml.Syntax;
import haxe.Int32;

/**
 * Conveniently, Int type in GM is already 64-bit.
 * @author YellowAfterlife
 */
@:hintType("int64") @:native("hx_int64")
abstract Int64(__Int64) {
	public inline function copy():Int64 return this;
	
	public static inline function make(high:Int32, low:Int32):Int64 {
		return (cast high << 32) | cast low;
	}
	
	@:from public static inline function ofInt(x:Int):Int64 {
		return untyped (x | 0);
	}
	
	public static inline function toInt(x:Int64):Int {
		return Syntax.div(untyped x >>> 0, 1);
	}
	
	@:deprecated('haxe.Int64.is() is deprecated. Use haxe.Int64.isInt64() instead')
	inline public static function is(val:Dynamic):Bool {
		return isInt64(val);
	}
	inline public static function isInt64(val:Dynamic):Bool {
		return gml.NativeType.isInt64(val);
	}
	
	private var raw(get, never):Int;
	private inline function get_raw():Int return this;
	private static inline function mkr(v:Int):Int64 return cast v;
	
	public static inline function isNeg(x:Int64):Bool {
		return x.raw < 0;
	}
	
	public static inline function isZero(x:Int64):Bool {
		return x.raw == 0;
	}
	
	public static inline function compare(a:Int64, b:Int64):Int {
		return untyped a - b;
	}
	
	public static function ucompare(a:Int64, b:Int64):Int {
		var diff = ((a.raw >> 32) >>> 0) - ((b.raw >> 32) >>> 0);
		if (diff == 0) {
			return (a.raw >>> 0) - (b.raw >>> 0);
		} else return diff;
	}
	
	public static inline function toStr(x:Int64):String {
		return x.toString();
	}
	
	public inline function toString():String {
		return SfTools.raw("string")(this);
	}
	
	public static inline function parseString(s:String):Int64 {
		return SfTools.raw("int64")(s);
	}
	
	public static inline function fromFloat(f:Float):Int64 {
		return SfTools.raw("int64")(f);
	}
	
	public static function divMod(dividend:Int64, divisor:Int64):Int64_DivMod {
		if (divisor.raw == 0) throw "divide by zero";
		var r:Int64_DivMod = {
			quotient: SfTools.raw("(({0}) | 0)", dividend.raw / divisor.raw),
			modulus:  SfTools.raw("(({0}) | 0)", dividend.raw % divisor.raw)
		};
		return r;
	}
	
	@:op(-A) public static inline function neg(x:Int64):Int64 {
		return -x;
	}
	
	@:op(A + B) public static inline function add(a:Int64, b:Int64):Int64 {
		return mkr(a.raw + b.raw);
	}
	@:op(A + B) @:commutative static inline function addInt(a:Int64, b:Int):Int64 {
		return mkr(a.raw + b);
	}
	
	@:op(A - B) public static inline function sub(a:Int64, b:Int64):Int64 {
		return mkr(a.raw - b.raw);
	}
	@:op(A - B) static inline function subInt(a:Int64, b:Int):Int64 {
		return mkr(a.raw - b);
	}
	@:op(A - B) static inline function intSub(a:Int, b:Int64):Int64 {
		return mkr(a - b.raw);
	}
	
	@:op(A * B) public static inline function mul(a:Int64, b:Int64):Int64 {
		return mkr(a.raw * b.raw);
	}
	@:op(A * B) @:commutative static inline function mulInt(a:Int64, b:Int):Int64 {
		return mkr(a.raw * b);
	}
	
	@:op(A / B) public static inline function div(a:Int64, b:Int64):Int64 {
		// this is OK specifically because Std.int is (v|0)
		return mkr(Std.int(a.raw / b.raw));
	}
	@:op(A / B) static inline function divInt(a:Int64, b:Int):Int64 {
		return mkr(Std.int(a.raw / b));
	}
	@:op(A / B) static inline function intDiv(a:Int, b:Int64):Int64 {
		return mkr(Std.int(a / b.raw));
	}
	
	@:op(A % B) public static inline function mod(a:Int64, b:Int64):Int64 {
		return mkr(a.raw % b.raw);
	}
	@:op(A % B) static inline function modInt(a:Int64, b:Int):Int64 {
		return mkr(a.raw % b);
	}
	@:op(A % B) static inline function intMod(a:Int, b:Int64):Int64 {
		return mkr(a % b.raw);
	}
	
	@:op(A == B) public static inline function eq(a:Int64, b:Int64):Bool {
		return a.raw == b.raw;
	}
	@:op(A == B) @:commutative static inline function eqInt(a:Int64, b:Int):Bool {
		return a.raw == b;
	}
	
	@:op(A != B) public static inline function neq(a:Int64, b:Int64):Bool {
		return a.raw != b.raw;
	}
	@:op(A != B) @:commutative static inline function neqInt(a:Int64, b:Int):Bool {
		return a.raw != b;
	}
	
	@:op(A < B) public static inline function lt(a:Int64, b:Int64):Bool {
		return a.raw < b.raw;
	}
	@:op(A < B) static inline function ltInt(a:Int64, b:Int):Bool {
		return a.raw < b;
	}
	@:op(A < B) static inline function intLt(a:Int, b:Int64):Bool {
		return a < b.raw;
	}
	
	@:op(A <= B) public static inline function lte(a:Int64, b:Int64):Bool {
		return a.raw <= b.raw;
	}
	@:op(A <= B) static inline function lteInt(a:Int64, b:Int):Bool {
		return a.raw <= b;
	}
	@:op(A <= B) static inline function intLte(a:Int, b:Int64):Bool {
		return a <= b.raw;
	}
	
	@:op(A > B) public static inline function gt(a:Int64, b:Int64):Bool {
		return a.raw > b.raw;
	}
	@:op(A > B) static inline function gtInt(a:Int64, b:Int):Bool {
		return a.raw > b;
	}
	@:op(A > B) static inline function intGt(a:Int, b:Int64):Bool {
		return a > b.raw;
	}
	
	@:op(A >= B) public static inline function gte(a:Int64, b:Int64):Bool {
		return a.raw >= b.raw;
	}
	@:op(A >= B) static inline function gteInt(a:Int64, b:Int):Bool {
		return a.raw >= b;
	}
	@:op(A >= B) static inline function intGte(a:Int, b:Int64):Bool {
		return a >= b.raw;
	}
	
	@:op(~A) static inline function bitNot(a:Int64):Int64 {
		return mkr(~a.raw);
	}
	
	@:op(A & B) public static inline function and(a:Int64, b:Int64):Int64 {
		return mkr(a.raw & b.raw);
	}
	
	@:op(A | B) public static inline function or(a:Int64, b:Int64):Int64 {
		return mkr(a.raw | b.raw);
	}
	
	@:op(A ^ B) public static inline function xor(a:Int64, b:Int64):Int64 {
		return mkr(a.raw ^ b.raw);
	}
	
	@:op(A << B) public static inline function shl(a:Int64, b:Int):Int64 {
		return mkr(a.raw << b);
	}
	
	@:op(A >> B) public static inline function shr(a:Int64, b:Int):Int64 {
		return mkr(a.raw >> b);
	}
	
	@:op(A >>> B) public static function ushr(a:Int64, b:Int):Int64 {
		if (b == 0) return a;
		if (b >= 32) return a.high >>> (b - 32);
		return make(a.high >>> b, ((a.high << (32 - b)) >>> 0) | (a.low >>> b));
	}
	
	@:op(++A) public inline function preInc():Int64 {
		return mkr(untyped ++this);
	}
	@:op(--A) public inline function preDec():Int64 {
		return mkr(untyped --this);
	}
	@:op(A++) public inline function postInc():Int64 {
		return mkr(untyped this++);
	}
	@:op(A--) public inline function postDec():Int64 {
		return mkr(untyped this--);
	}
	
	public var high(get, set):Int;
	inline function get_high() return (cast this) >> 32;
	inline function set_high(v:Int) {
		this = ((cast this) >>> 0) | (v << 32);
		return v;
	}
	
	public var low(get, set):Int;
	inline function get_low() return Syntax.div((this >>> 0), 1);
	inline function set_low(v:Int) {
		this = (this & ~(cast 4294967295)) | (v >>> 0);
		return v;
	}
}

private typedef __Int64 = Dynamic;
@:nativeGen typedef Int64_DivMod = {
	quotient:Int64,
	modulus:Int64
}
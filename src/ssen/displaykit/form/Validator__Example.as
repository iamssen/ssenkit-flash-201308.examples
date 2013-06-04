package ssen.displaykit.form {

public class Validator__Example {
	
	[Test]
	public function testCustomValidator():void {
		var val:CustomAgeValidator=new CustomAgeValidator;
		trace("Validator__Example.testCustomValidator()", val.validate(76));
	
	}
}
}
import mx.validators.ValidationResult;
import mx.validators.Validator;

class CustomAgeValidator extends Validator {
	
	override protected function doValidation(value:Object):Array {
		var valid:Array=super.doValidation(value);
		
		if (valid.length > 0) {
			return valid;
		}
		
		if (String(value).length === 0 || isNaN(Number(value))) {
			return valid;
		}
		
		var num:Number=Number(value);
		
		if (num < 15) {
			valid.push(new ValidationResult(true, null, "Age is low", "Age is under 15"));
		} else if (num > 45) {
			valid.push(new ValidationResult(true, null, "Age is up", "Age is over 45"));
		}
		
		return valid;
	}

}

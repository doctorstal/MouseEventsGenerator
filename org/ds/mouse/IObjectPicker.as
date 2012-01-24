package org.ds.mouse {
	
	/**
	 * ...
	 * @author DoctorSTaL
	 */
	public interface IObjectPicker {
		function getObjectUnderPoint(globalX:Number,globalY:Number):IMousePickable;
	}
	
}
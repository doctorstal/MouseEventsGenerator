package org.ds.mouse {
	
	/**
	 * ...
	 * @author DoctorSTaL
	 */
	
	import flash.events.MouseEvent;
	
	public interface IMousePickable{
		function getParentChain():Vector.<IMousePickable>;
		function processEvent(event:MouseEvent):void;
	}
	
}
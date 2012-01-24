package org.ds.mouse {
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author DoctorSTaL
	 */
	[Event(name = "click", type = "flash.events.MouseEvent")]
	[Event(name = "mouseDown", type = "flash.events.MouseEvent")]
	[Event(name = "mouseUp", type = "flash.events.MouseEvent")]
	[Event(name = "mouseMove", type = "flash.events.MouseEvent")]
	[Event(name = "mouseOver", type = "flash.events.MouseEvent")]
	[Event(name = "mouseOut", type = "flash.events.MouseEvent")]
	
	[Event(name = "rollOver", type = "flash.events.MouseEvent")]
	[Event(name = "rollOut", type = "flash.events.MouseEvent")]
	
	public interface IInteractiveObject extends IEventDispatcher{
		function get mouseEnabled():Boolean;
		function set mouseEnabled(val:Boolean):void;
		
		function get mouseChildren():Boolean;
		function set mouseChildren(val:Boolean):void;
		
	}
	
}
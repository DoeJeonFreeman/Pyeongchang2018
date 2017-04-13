/*
	Author:Jim Robson http://www.robsondesign.com/blog/
	Copyright (c) 2007 Eye Street Software Corporation - http://www.eyestreet.com
	
	Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
	and associated documentation files (the "Software"), to deal in the Software without restriction, 
	including without limitation the rights to use, copy, modify, merge, publish, distribute, 
	sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is 
	furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in all copies or 
	substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT 
	NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
	DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
package com.doe.flex.ui.form.util 
{
	
	import flash.events.Event;
	import flash.sampler.getMemberNames;
	
	import mx.controls.Alert;
	
	/**
	 * Creates a Master / Subordinate relationship for a group of checkboxes. 
	 * <p> The Master checkbox is a 'select all' box: when it is selected, all
	 * of the subordinates are selected; when it is de-selected, all of the subordinates
	 * are de-selected. </p><p>The subordinates have the corresponding effect on the 
	 * master: if the user de-selects one of the subordinates, the master is also de-selected.
	 * If the user's selection of a subordinate results in all of the subordinates being selected,
	 * then the master is also selected.</p><p>An optional "other" checkbox provides functionality
	 * for "none of the above" / "other" options. If this parameter is supplied, and the user
	 * selects this checkbox, it de-selects all other checkboxes in the group.</p>
	 */
	public class CheckBoxGroup 
	{
		
		/**
		 * Constructor
		 * @param master Checkbox that controls the other checkboxes in the group
		 * @param subs Array of checkboxes that are subordinate to the master
		 */
		public function CheckBoxGroup(master:ImageCheckBox, subs:Array, other:ImageCheckBox=null)
		{
			this._master = master;
			this._subs = subs;
			this._other = other;
			testSubs();
			storeStates();
			addEventListeners();
		}
		
		/**
		 * Ensures that the array of subordinates includes only CheckBox instances
		 */
		protected function testSubs(): void
		{
			for(var i:String in _subs)
			{
				if(!(_subs[i] is ImageCheckBox))
				{
					throw new Error("The array provided to the CheckBoxGroup constructor must contain only CheckBox instances.");
				}
			}
		}
		
		/**
		 * Stores current state (selected / not selected) of the CheckBox instances
		 */
		protected function storeStates(): void
		{
			_masterSelected = _master.selected;
			for(var i:int = 0; i < _subs.length; i++)
			{
				var selected:Boolean = _subs[i].selected;
				_subsSelected[i] = selected;
			}
		}
		
		/**
		 * Assigns event listeners to the master and subordinate checkboxes
		 */
		protected function addEventListeners(): void
		{
			_master.addEventListener(Event.CHANGE, selectAll);
			for each(var checkbox:ImageCheckBox in _subs)
			{
				checkbox.addEventListener(Event.CHANGE, selectSome);
			}
			if(_other != null) _other.addEventListener(Event.CHANGE, selectNone);
		}
		
		/**
		 * Handles Master checkbox change events. When the master is selected, 
		 * it selects all subordinates. When the master is de-selected, it 
		 * de-selects all subordinates. 
		 */
		protected function selectAll(event:Event): void
		{
			var selected:Boolean = event.target.selected;
			for each(var checkbox:ImageCheckBox in _subs) 
			{
				checkbox.selected = selected;
			} 
			if(selected && _other != null){
				_other.selected = false;
			} 
			Alert.show('['+(event.currentTarget.id).toString() + ' / ' +(event.currentTarget.selected).toString()+']')
			
			
		}
		
		/**
		 * Handles Subordinate checkbox change events. If all subordinates
		 * are selected, this function selects the master; otherwise, it
		 * de-selects the master.
		 */
		protected function selectSome(event:Event): void
		{
			_master.removeEventListener(Event.CHANGE, selectAll);
			_master.selected = allSelected();
			_master.addEventListener(Event.CHANGE, selectAll);
			if(_master.selected && _other != null){
				_other.selected = false;
			} 
			Alert.show((event.currentTarget.id).toString() + ' / ' +(event.currentTarget.selected).toString());
			
		}
		
		/**
		 * Handles Other checkbox change events. When the "other" checkbox is selected,
		 * this function de-selects all other checkboxes in the group. When the "other"
		 * checkbox is de-selected, all other checkboxes in the group are returned to
		 * their most recent state.
		 */
		protected function selectNone(event:Event): void 
		{
			var selected:Boolean = event.target.selected;
			if(selected)
			{
				storeStates();
				_master.selected = false;
				if(!_masterSelected)
				{
					for each(var checkbox:ImageCheckBox in _subs)
					{
						checkbox.selected = false
					}
				}
			}
			else if(!_master.selected)
			{
				_master.selected = _masterSelected;
				for(var i:int = 0; i < _subsSelected.length; i++)
				{
					_subs[i].selected = _subsSelected[i];
				}
			}
			
			
		}
		
		/**
		 * Checks to see whether all subordinates are selected. Returns 
		 * true if all are selected, false if one or more are not selected.
		 */
		protected function allSelected(): Boolean
		{
			var allSelected:Boolean = true;
			for each(var checkbox:ImageCheckBox in _subs)
			{
				if(!checkbox.selected)
				{
					allSelected = false;
					break;
				}
			}
			return allSelected;
		}
		
		// Master checkbox
		private var _master:CheckBox;
		// Subordinate checkboxes
		private var _subs:Array = [];
		// Other checkbox
		private var _other:CheckBox;
		// Boolean and arrays to store most recent states
		private var _masterSelected:Boolean;
		private var _subsSelected:Array = [];
	}
}
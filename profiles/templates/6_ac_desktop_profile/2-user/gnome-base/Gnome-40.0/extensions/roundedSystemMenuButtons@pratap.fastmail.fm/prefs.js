const GLib = imports.gi.GLib;
const Gtk = imports.gi.Gtk;
const Gdk = imports.gi.Gdk;

const ExtensionUtils = imports.misc.extensionUtils;

const initialArray = [
	'ORIENTATION BUTTON',
	'SETTINGS BUTTON',
	'LOCK BUTTON',
	'SUSPEND BUTTON',
	'SWITCH_USER BUTTON',
	'LOGOUT BUTTON',
	'RESTART BUTTON',
	'POWER BUTTON'
    	]

const GTK_VERSION = Gtk.get_major_version();
let add;
let addRow;
        if(GTK_VERSION == 4) {
		add = 'append';
		addRow = 'set_child';
					} else {
						add = 'add';
						addRow = 'add'; }

function init() {
}

function buildPrefsWidget() {
    let widget = new PrefsWidget();
    		if(GTK_VERSION == 3) {
    			widget.widget.show_all(); }
    return widget.widget;
}

class PrefsWidget {
	constructor() {
		this._settings = ExtensionUtils.getSettings();
		
		this.BC_button = new Gtk.ColorButton();
        	this._setButtonColor();
        	
		this.notebook = new Gtk.Notebook({ visible: true });
		
		this.widget = new Gtk.Grid({ visible: true, column_homogeneous: true });
		this.notebook = new Gtk.Notebook({ visible: true });
		
		this.listBox = [];
		
		this.listBox = new Gtk.ListBox({ visible: true });
		this.listBox.set_selection_mode(0);
		
		this.widget.attach(this.notebook, 0, 0, 1, 1);

		// Basic Settings Page
		    
    		let grid = new Gtk.Grid({
		column_spacing: 12, row_spacing: 12,
		column_homogeneous: true,
		hexpand: true, vexpand: true,
		margin_start: 14, margin_end: 14, margin_top: 14, margin_bottom: 14,
		visible: true
	    	});
    
    
    		let vbox = new Gtk.Box({ orientation: Gtk.Orientation.VERTICAL, spacing: 10, visible: true });
    
    		grid.attach(vbox, 0, 0, 3, 1);

	        vbox[add](this.selectButtonColor());
        	vbox[add](this.customColorButton());
        	vbox[add](this.adjustIconSize());
        	vbox[add](this.adjustPadding());
        	vbox[add](this.adjustBorderRadius());
        	vbox[add](this.resetButton());
        	vbox[add](new Gtk.Separator({ orientation: Gtk.Orientation.HORIZONTAL, margin_bottom: 10, margin_top: 10 }));
        	vbox[add](this.removeSuspendButton());
        	vbox[add](this.removeLogoutButton());
        	vbox[add](this.removeRestartButton());
        	vbox[add](this.removePoweroffButton());
        	vbox[add](new Gtk.Separator({ orientation: Gtk.Orientation.HORIZONTAL, margin_bottom: 10, margin_top: 10 }));
        	vbox[add](this.tip());
        	vbox[add](this.command());
    	
    		this.notebook.append_page(grid, new Gtk.Label({ label: 'Basic Settings', visible: true, hexpand: true }));
	    	
	    	// End of Basic Settings Page
	    	
	    	// Arrange Button Order Page
	    	
	    	this.Buttons = [];
		this.finalArray = [];
	    	
		let grid2 = new Gtk.Grid({
        	column_spacing: 12, row_spacing: 12,
        	column_homogeneous: true,
        	hexpand: true, vexpand: true,
        	margin_start: 14, margin_end: 14, margin_top: 14, margin_bottom: 14,
        	visible: true
    		});
    
		//let topHbox = new Gtk.Box({ orientation: Gtk.Orientation.HORIZONTAL, spacing: 20, visible: true });
        	//grid.attach(topHbox, 0, 0, 2, 1);
        
        	this.listBox = new Gtk.ListBox({ visible: true });
        	this.listBox.set_selection_mode(0);
        	
        	this._prepareRow(initialArray);
        	this._saveOrder();
        	this._removeListBox();
        	
        	let BUTTONS_ORDER = this._settings.get_value('buttons-order').deepUnpack();
        	let FINALARRAY = [];

		for (let i = 0; i < initialArray.length; i ++) {
			let text = initialArray[BUTTONS_ORDER[i]-1]
			FINALARRAY.push(text);
			}

        	this._prepareRow(FINALARRAY);
        	
        	grid2.attach(this.listBox, 0, 1, 1, 1);
        	
        	    	let RESET = new Gtk.Button();
        		RESET.set_label("Reset 'Buttons Order' to Extensions Default.");
        		RESET.connect("clicked", () => { 	this._removeListBox();
	    							this._prepareRow(initialArray);
	    							const value = new GLib.Variant('ai', [1, 2, 3, 4, 5, 6, 7, 8]);
	    							this._settings.set_value('buttons-order', value);
	    														});
	    		
        	grid2.attach(RESET, 0, 2, 1, 1);
    
    		this.notebook.append_page(grid2, new Gtk.Label({ label: "Arrange 'Buttons Order'", visible: true, hexpand: true }));
    		
    }
    		
    		// End of Arrange Button Order Page
    		
_prepareRow(ARRAY) {

		for(let i = 0; i < ARRAY.length; i++) {
		
	    		let row = new Gtk.ListBoxRow({ visible: true });
	    		
	    		let hbox = new Gtk.Box({ orientation: Gtk.Orientation.HORIZONTAL, visible: true });
	    		
	    		row[addRow](hbox);
	    		
	    		let TEXT = new Gtk.Button({ hexpand: true, margin_end: 10 });
	    		TEXT.set_label(ARRAY[i]);
	    		
	    		let ImageButton = new Gtk.Button({ margin_end: 10 });
	    		let B;
	    		
	    		let A = 'rotation-allowed-symbolic';
	    		
	  		GTK_VERSION == 4 ?
	  		    B = 'org.gnome.Settings-symbolic' : B = 'system-settings-symbolic';
	  		
	    		let C = 'changes-prevent-symbolic';
	    		let D = 'media-playback-pause-symbolic';
	    		let E = 'system-switch-user-symbolic';
	    		let F = 'system-log-out-symbolic';
	    		let G = 'system-reboot-symbolic';
	    		let H = 'system-shutdown-symbolic';
	    		
	    		if(TEXT.get_label() == initialArray[0])
	    			GTK_VERSION == 4 ? ImageButton.set_icon_name(A) : ImageButton.set_image(new Gtk.Image({ icon_name: A }));
	    		if(TEXT.get_label() == initialArray[1])
	    			GTK_VERSION == 4 ? ImageButton.set_icon_name(B) : ImageButton.set_image(new Gtk.Image({ icon_name: B }));
	    		if(TEXT.get_label() == initialArray[2])
	    			GTK_VERSION == 4 ? ImageButton.set_icon_name(C) : ImageButton.set_image(new Gtk.Image({ icon_name: C }));
	    		if(TEXT.get_label() == initialArray[3])
	    			GTK_VERSION == 4 ? ImageButton.set_icon_name(D) : ImageButton.set_image(new Gtk.Image({ icon_name: D }));
	    		if(TEXT.get_label() == initialArray[4])
	    			GTK_VERSION == 4 ? ImageButton.set_icon_name(E) : ImageButton.set_image(new Gtk.Image({ icon_name: E }));
	    		if(TEXT.get_label() == initialArray[5])
	    			GTK_VERSION == 4 ? ImageButton.set_icon_name(F) : ImageButton.set_image(new Gtk.Image({ icon_name: F }));
	    		if(TEXT.get_label() == initialArray[6])
	    			GTK_VERSION == 4 ? ImageButton.set_icon_name(G) : ImageButton.set_image(new Gtk.Image({ icon_name: G }));
	    		if(TEXT.get_label() == initialArray[7])
	    			GTK_VERSION == 4 ? ImageButton.set_icon_name(H) : ImageButton.set_image(new Gtk.Image({ icon_name: H }));
	    		
	    		let upButton = new Gtk.Button({margin_end: 10});
	    		GTK_VERSION == 4 ? upButton.set_icon_name('go-up-symbolic') : upButton.set_image(new Gtk.Image({ icon_name: 'go-up-symbolic' }));
	    		upButton.connect("clicked", () => { this._moveUp(i) });
	    		
	    		let downButton = new Gtk.Button();
	    		GTK_VERSION == 4 ? downButton.set_icon_name('go-down-symbolic') : downButton.set_image(new Gtk.Image({ icon_name: 'go-down-symbolic' }));
	    		downButton.connect("clicked", () => { this._moveDown(i) });
	    		
	    		hbox[add](ImageButton);
	    		hbox[add](TEXT);
	    		hbox[add](upButton);
	    		hbox[add](downButton);
	    		
	    		this.listBox[add](row)
	    		}
    		
    }
		
_arraymove(array, fromIndex, toIndex) {
    let element = array[fromIndex];
        array.splice(fromIndex, 1);
    array.splice(toIndex, 0, element);
    }
		
_saveOrder () {

	if(GTK_VERSION == 4) {
		for (let i = 0; i < initialArray.length; i++) {	
			let entry = this.listBox.get_row_at_index(i).get_child().get_first_child();
			entry = entry.get_next_sibling();
			let label = entry.get_label();
			this.Buttons.push(label);
				}
		} else {
			for (let i = 0; i < initialArray.length; i++) {	
				let label = this.listBox.get_row_at_index(i).get_child().get_children()[1].get_label();
				this.Buttons.push(label);
				}
		}	

    }

_removeListBox () {
	if(GTK_VERSION == 4) {
		let child = this.listBox.get_first_child();
			while (child != null) {
			    let next = child.get_next_sibling();
			    this.listBox.remove(child);
			    child = next;
			}
	} else {
		this.listBox.foreach((element) => this.listBox.remove(element));
			}
    }
		
_moveUp (i) {
	this.Buttons = [];
	this._saveOrder();
	
	this._removeListBox();
		
	if(i == 0) { 
		this._arraymove(this.Buttons, 0, 7);
		} else {
			this._arraymove(this.Buttons, i, i-1) }
	
        this._prepareRow(this.Buttons);
        
        this.finalArray = [];
        
        for (let i = 0; i < initialArray.length; i ++) {
		let index = initialArray.indexOf(this.Buttons[i]) + 1;
		this.finalArray.push(index);
		}
        
        const value = new GLib.Variant('ai', this.finalArray);
    	this._settings.set_value('buttons-order', value);
    }
    
_moveDown (i) {
	this.Buttons = [];
	this._saveOrder();
	
	this._removeListBox();
		
	if(i == 7) { 
		this._arraymove(this.Buttons, 7, 0);
		} else {
			this._arraymove(this.Buttons, i, i+1) }
	
	this._prepareRow(this.Buttons);
        
        this.finalArray = [];
        
        for (let i = 0; i < initialArray.length; i ++) {
		let index = initialArray.indexOf(this.Buttons[i]) + 1;
		this.finalArray.push(index);
		}
        
        const value = new GLib.Variant('ai', this.finalArray);
    	this._settings.set_value('buttons-order', value);
    }
	
_setButtonColor() {
        let rgba = new Gdk.RGBA();
        let hexString = this._settings.get_string('color');
        rgba.parse(hexString);
        this.BC_button.set_rgba(rgba);
    }
    
    
_cssHexString(css) {
        let rrggbb = '#';
        let start;
        for(let loop = 0; loop < 3; loop++) {
            let end = 0;
            let xx = '';
            for(let loop = 0; loop < 2; loop++) {
                while(true) {
                    let x = css.slice(end, end + 1);
                    if(x == '(' || x == ',' || x == ')')
                        break;
                    end = end + 1;
                }
                if(loop == 0) {
                    end = end + 1;
                    start = end;
                }
            }
            xx = parseInt(css.slice(start, end)).toString(16);
            if(xx.length == 1)
                xx = '0' + xx;
            rrggbb = rrggbb + xx;
            css = css.slice(end);
        }
        return rrggbb;
    }
    
_onPanelColorChanged() {
        let rgba = this.BC_button.get_rgba();
        let css = rgba.to_string();
        let hexString = this._cssHexString(css);
        this._settings.set_string('color', hexString);
    }    
    
selectButtonColor() {
	let hbox = new Gtk.Box({ orientation: Gtk.Orientation.HORIZONTAL, margin_top: 5, halign: Gtk.Align.END  });
	
	this.BC_button.connect('notify::rgba', ()=> this._onPanelColorChanged() );
	
	hbox[add](this.BC_button);
	
        return hbox;
    }
    
customColorButton() {
    	let hbox = new Gtk.Box({ orientation: Gtk.Orientation.HORIZONTAL, margin_top: 5 });
    	let customColorButtonLabel = new Gtk.Label({ label: "Use Custom Color for Buttons", xalign: 0, hexpand: true });
    	
        this.cCBToggleSwitch = new Gtk.Switch({ active: this._settings.get_boolean('use-custom-color') });
        this.cCBToggleSwitch.connect('notify::active', (button) => { this._settings.set_boolean('use-custom-color', button.active); });
    	
		hbox[add](customColorButtonLabel);
		hbox[add](this.cCBToggleSwitch)
      	
      	return hbox;
    } 
    
removeSuspendButton() {
    	let hbox = new Gtk.Box({ orientation: Gtk.Orientation.HORIZONTAL, margin_top: 5  });
    	let removeSuspendButtonLabel = new Gtk.Label({ label: "Remove Suspend Button", xalign: 0, hexpand: true });
    	
        this.rSBLToggleSwitch = new Gtk.Switch({ active: this._settings.get_boolean('remove-suspend-button') });
        this.rSBLToggleSwitch.connect('notify::active', (button) => { this._settings.set_boolean('remove-suspend-button', button.active); }); 
    	
		hbox[add](removeSuspendButtonLabel);
		hbox[add](this.rSBLToggleSwitch)
		
      	return hbox;
    } 
    
removeLogoutButton() {
    	let hbox = new Gtk.Box({ orientation: Gtk.Orientation.HORIZONTAL, margin_top: 5 });
    	let removeLogoutButtonLabel = new Gtk.Label({ label: "Remove Logout Button", xalign: 0, hexpand: true });
    	
        this.rLBLToggleSwitch = new Gtk.Switch({ active: this._settings.get_boolean('remove-logout-button') });
        this.rLBLToggleSwitch.connect('notify::active', (button) => { this._settings.set_boolean('remove-logout-button', button.active); }); 
    	
		hbox[add](removeLogoutButtonLabel);
		hbox[add](this.rLBLToggleSwitch)
		
      	return hbox;
    }
    
removeRestartButton() {
    	let hbox = new Gtk.Box({ orientation: Gtk.Orientation.HORIZONTAL, margin_top: 5 });
    	let removeRestartButtonLabel = new Gtk.Label({ label: "Remove Restart Button", xalign: 0, hexpand: true });
    	
        this.rRBLToggleSwitch = new Gtk.Switch({ active: this._settings.get_boolean('remove-restart-button') });
        this.rRBLToggleSwitch.connect('notify::active', (button) => { this._settings.set_boolean('remove-restart-button', button.active); }); 
    	
		hbox[add](removeRestartButtonLabel);
		hbox[add](this.rRBLToggleSwitch);
		
      	return hbox;
    } 
    
removePoweroffButton() {
    	let hbox = new Gtk.Box({ orientation: Gtk.Orientation.HORIZONTAL, margin_top: 5 });
    	let removePoweroffButtonLabel = new Gtk.Label({ label: "Remove Poweroff Button", xalign: 0, hexpand: true });
    	
        this.rPBLToggleSwitch = new Gtk.Switch({ active: this._settings.get_boolean('remove-poweroff-button') });
        this.rPBLToggleSwitch.connect('notify::active', (button) => { this._settings.set_boolean('remove-poweroff-button', button.active); }); 
    	
		hbox[add](removePoweroffButtonLabel);
		hbox[add](this.rPBLToggleSwitch)
		
      	return hbox;
    } 
    
adjustIconSize() {
	let hbox = new Gtk.Box({ orientation: Gtk.Orientation.HORIZONTAL, margin_top: 5 });
	let IS_label = new Gtk.Label({ label: "Adjust Icon Size", xalign: 0, hexpand: true });

	this.IS_button = new Gtk.SpinButton();
	this.IS_button.set_range(12, 20);
	this.IS_button.set_value(this._settings.get_int('icon-size'));
	this.IS_button.set_increments(2, 4);
	this.IS_button.connect('value-changed', (entry) => { this._settings.set_int('icon-size', entry.get_value()); });
	
		hbox[add](IS_label);
		hbox[add](this.IS_button);
		
        return hbox;
    }
    
adjustPadding() {
        let hbox = new Gtk.Box({ orientation: Gtk.Orientation.HORIZONTAL, margin_top: 5 });
        let PD_label = new Gtk.Label({ label: "Adjust Padding", xalign: 0, hexpand: true });

        this.PD_button = new Gtk.SpinButton();
	this.PD_button.set_range(0, 16);
	this.PD_button.set_value(this._settings.get_int('padding'));
	this.PD_button.set_increments(2, 4);
	this.PD_button.connect('value-changed', (entry) => { this._settings.set_int('padding', entry.get_value()); });
	
		hbox[add](PD_label);
		hbox[add](this.PD_button);

        return hbox;
    }  
    
adjustBorderRadius() {
	let hbox = new Gtk.Box({ orientation: Gtk.Orientation.HORIZONTAL, margin_top: 5 });
	let BR_label = new Gtk.Label({ label: "Adjust Border Raidus", xalign: 0, hexpand: true });
	this.BR_button = new Gtk.SpinButton();
	this.BR_button.set_range(0, 32);
	this.BR_button.set_value(this._settings.get_int('border-radius'));
	this.BR_button.set_increments(2, 4);
	this.BR_button.connect('value-changed', (entry) => { this._settings.set_int('border-radius', entry.get_value()); });
	
		hbox[add](BR_label);
		hbox[add](this.BR_button);

        return hbox;
    }
    
resetButton() {
    	let hbox = new Gtk.Box({ orientation: Gtk.Orientation.HORIZONTAL, margin_top: 5, halign: Gtk.Align.CENTER  });
    	let resetButton = new Gtk.Button();
        resetButton.set_label("Reset to Extensions's Default Size'es By Cliking this Button");
        resetButton.connect('clicked', ()=> {	
        	this._settings.set_int('icon-size', 16);
        	this._settings.set_int('padding', 8);
        	this._settings.set_int('border-radius', 16);
			this.IS_button.set_value(this._settings.get_int('icon-size'));
			this.PD_button.set_value(this._settings.get_int('padding'));
			this.BR_button.set_value(this._settings.get_int('border-radius'));
			
       		});
	
		hbox[add](resetButton);

        return hbox;
    }  
    
tip() {
    	let hbox = new Gtk.Box({ orientation: Gtk.Orientation.HORIZONTAL, margin_top: 5, halign: Gtk.Align.START  });
    	let tipLabel = new Gtk.Label({ label:
    	"you can tweak the BACKGROUND COLOR of these system menu buttons by edititng this extensions stylesheet.css file.\n\
Run below command to open the styles sheet file." });
    	
	hbox[add](tipLabel);
		
        return hbox;
    }     
    
command() {
    	let hbox = new Gtk.Box({ orientation: Gtk.Orientation.HORIZONTAL, margin_top: 5, margin_bottom: 20, halign: Gtk.Align.START  });
    	let command = new Gtk.Label({ label: "<b>gedit $HOME/.local/share/gnome-shell/extensions/roundedSystemMenuButtons@pratap.fastmail.fm/stylesheet.css</b>", useMarkup: true, selectable: true });
    	
		hbox[add](command);
      	
      	return hbox;
    } 
}

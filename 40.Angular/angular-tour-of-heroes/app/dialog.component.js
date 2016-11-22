"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var core_1 = require('@angular/core');
var DialogComponent = (function () {
    function DialogComponent() {
        this.closable = true;
        this.visibleChange = new core_1.EventEmitter();
    }
    DialogComponent.prototype.ngOnInit = function () { };
    DialogComponent.prototype.close = function () {
        this.visible = false;
        this.visibleChange.emit(this.visible);
    };
    __decorate([
        core_1.Input(), 
        __metadata('design:type', Object)
    ], DialogComponent.prototype, "closable", void 0);
    __decorate([
        core_1.Input(), 
        __metadata('design:type', Boolean)
    ], DialogComponent.prototype, "visible", void 0);
    __decorate([
        core_1.Output(), 
        __metadata('design:type', core_1.EventEmitter)
    ], DialogComponent.prototype, "visibleChange", void 0);
    DialogComponent = __decorate([
        core_1.Component({
            moduleId: module.id,
            selector: 'my-dialog',
            templateUrl: 'html/dialog.component.html',
            styleUrls: ['css/dialog.component.css'],
            animations: [
                core_1.trigger('dialog', [
                    core_1.transition('void => *', [
                        core_1.style({ transform: 'scale3d(.3, .3, .3)' }),
                        core_1.animate(100)
                    ]),
                    core_1.transition('* => void', [
                        core_1.animate(100, core_1.style({ transform: 'scale3d(.0, .0, .0)' }))
                    ])
                ])
            ]
        }), 
        __metadata('design:paramtypes', [])
    ], DialogComponent);
    return DialogComponent;
}());
exports.DialogComponent = DialogComponent;
//# sourceMappingURL=dialog.component.js.map
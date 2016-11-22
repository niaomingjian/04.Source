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
var hero_1 = require('./hero');
var hero_service_1 = require('./hero.service');
var HeroFormComponent = (function () {
    function HeroFormComponent(heroService) {
        this.heroService = heroService;
        this.powers = ['Really Smart', 'Super Flexible',
            'Super Hot', 'Weather Changer'];
        this.model = new hero_1.Hero(18, 'Dr IQ', this.powers[0], 'Chuck Overstreet');
        this.submitted = false;
        this.active = true;
    }
    HeroFormComponent.prototype.onSubmit = function () {
        var _this = this;
        this.submitted = true;
        this.heroService.createFromHero(this.model)
            .then(function (hero) { return _this.model = hero; });
    };
    HeroFormComponent.prototype.newHero = function () {
        var _this = this;
        this.model = new hero_1.Hero(42, '', '');
        this.active = false;
        setTimeout(function () { return _this.active = true; }, 0);
    };
    HeroFormComponent = __decorate([
        core_1.Component({
            moduleId: module.id,
            selector: 'hero-form',
            templateUrl: 'html/hero-form.component.html',
            styleUrls: ['css/hero-form.component.css']
        }), 
        __metadata('design:paramtypes', [hero_service_1.HeroService])
    ], HeroFormComponent);
    return HeroFormComponent;
}());
exports.HeroFormComponent = HeroFormComponent;
//# sourceMappingURL=hero-form.component.js.map
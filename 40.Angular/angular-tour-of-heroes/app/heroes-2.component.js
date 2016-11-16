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
var router_1 = require('@angular/router');
var hero_service_1 = require('./hero.service');
var HeroesComponent_2 = (function () {
    function HeroesComponent_2(router, heroService) {
        this.router = router;
        this.heroService = heroService;
        this.hero = {
            id: 1,
            name: 'windstorm'
        };
    }
    HeroesComponent_2.prototype.onSelect = function (hero) {
        this.selectedHero = hero;
    };
    HeroesComponent_2.prototype.getHeroes = function () {
        var _this = this;
        this.heroService.getHeroes().then(function (heroes) { return _this.heroes = heroes; });
    };
    HeroesComponent_2.prototype.ngOnInit = function () {
        this.getHeroes();
    };
    HeroesComponent_2.prototype.gotoDetail = function () {
        this.router.navigate(['/detail', this.selectedHero.id]);
    };
    HeroesComponent_2 = __decorate([
        core_1.Component({
            moduleId: module.id,
            selector: 'my-heroes',
            templateUrl: 'html/heroes-2.component.html',
            styleUrls: ['css/heroes-2.component.css']
        }), 
        __metadata('design:paramtypes', [router_1.Router, hero_service_1.HeroService])
    ], HeroesComponent_2);
    return HeroesComponent_2;
}());
exports.HeroesComponent_2 = HeroesComponent_2;
//# sourceMappingURL=heroes-2.component.js.map
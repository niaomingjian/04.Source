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
var platform_browser_1 = require('@angular/platform-browser');
var forms_1 = require('@angular/forms');
var http_1 = require('@angular/http');
// import { InMemoryWebApiModule } from 'angular-in-memory-web-api';
// import { InMemoryDataService }  from './in-memory-data.service';
var app_component_1 = require('./app.component');
var heroes_component_1 = require('./heroes.component');
var heroes_2_component_1 = require('./heroes-2.component');
var hero_detail_component_1 = require('./hero-detail.component');
var dashboard_component_1 = require('./dashboard.component');
var hero_search_component_1 = require('./hero-search.component');
var hero_form_component_1 = require('./hero-form.component');
var dialog_component_1 = require('./dialog.component');
var search_component_1 = require('./search.component');
var hero_service_1 = require('./hero.service');
var app_routing_module_1 = require('./app-routing.module');
require('./rxjs-extensions');
var AppModule = (function () {
    function AppModule() {
    }
    AppModule = __decorate([
        core_1.NgModule({
            imports: [
                platform_browser_1.BrowserModule,
                forms_1.FormsModule,
                http_1.HttpModule,
                // InMemoryWebApiModule.forRoot(InMemoryDataService),
                app_routing_module_1.AppRoutingModule
            ],
            declarations: [
                app_component_1.AppComponent,
                heroes_component_1.HeroesComponent,
                heroes_2_component_1.HeroesComponent_2,
                hero_detail_component_1.HeroDetailComponent,
                dashboard_component_1.DashboardComponent,
                hero_search_component_1.HeroSearchComponent,
                hero_form_component_1.HeroFormComponent,
                dialog_component_1.DialogComponent,
                search_component_1.SearchComponent
            ],
            providers: [
                hero_service_1.HeroService
            ],
            bootstrap: [app_component_1.AppComponent]
        }), 
        __metadata('design:paramtypes', [])
    ], AppModule);
    return AppModule;
}());
exports.AppModule = AppModule;
//# sourceMappingURL=app.module.js.map
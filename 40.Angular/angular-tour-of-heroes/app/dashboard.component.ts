import { Component, OnInit  } from '@angular/core';

import { Hero } from './hero';
import { HeroService } from './hero.service';

@Component({
    moduleId: module.id,
    selector: 'my-dashboard',
    templateUrl: 'html/dashboard.component.html',
    styleUrls: [ 'css/dashboard.component.css' ]
})
export class DashboardComponent {
    heroes: Hero[] = [];
    selectedHero: Hero;

    constructor(private heroService: HeroService) { }

    ngOnInit(): void {
        this.heroService.getHeroes()
        .then(heroes => this.heroes = heroes);
    }

    showDialog = false;

    onSelect(hero: Hero): void {
        this.selectedHero = hero;
    }
 }
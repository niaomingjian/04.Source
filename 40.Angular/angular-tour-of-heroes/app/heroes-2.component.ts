import { Component } from '@angular/core';
import { Hero } from './hero';
import { OnInit } from '@angular/core';
import { Router }   from '@angular/router';

import { HeroService } from './hero.service';

@Component({
  moduleId: module.id,
  selector: 'my-heroes',
  templateUrl: 'html/heroes-2.component.html',
  styleUrls: [ 'css/heroes-2.component.css' ]
})
export class HeroesComponent_2 { 

  hero: Hero;
  heroes: Hero[];
  selectedHero: Hero;
  
  onSelect(hero: Hero): void {
    this.selectedHero = hero;
  }
  
  constructor(private router: Router,private heroService: HeroService) { }
  
  getHeroes(): void {
    this.heroService.getHeroes().then(heroes => this.heroes = heroes);
  }
  
  ngOnInit(): void {
    this.getHeroes();
  }

  gotoDetail(): void {
    this.router.navigate(['/detail', this.selectedHero.id]);
  }
}

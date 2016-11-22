import { Component } from '@angular/core';
import { Hero }    from './hero';

import { HeroService } from './hero.service';

@Component({
  moduleId: module.id,
  selector: 'hero-form',
  templateUrl: 'html/hero-form.component.html',
  styleUrls: ['css/hero-form.component.css']
})
export class HeroFormComponent {
    powers = ['Really Smart', 'Super Flexible',
        'Super Hot', 'Weather Changer'];
    
    model = new Hero(18, 'Dr IQ', this.powers[0], 'Chuck Overstreet');

    submitted = false;
    active = true;

    constructor(private heroService: HeroService){}

    onSubmit() { 
        this.submitted = true;
        this.heroService.createFromHero(this.model)
        .then(hero => this.model = hero);
    }

    newHero() {
        this.model = new Hero(42, '', '');
        this.active = false;
        setTimeout(() => this.active = true, 0);
    }
}